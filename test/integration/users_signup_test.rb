require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    email                 = "user@invalid"
    password              = "foo"
    password_confirmation = "bar"
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: email, password: password, password_confirmation: password_confirmation } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid signup information" do
    get signup_path
    email    = "user@example.com"
    password = "foobar"
    assert_difference 'User.count' do
      post users_path, params: { user: { email: email, password: password, password_confirmation: password } }
    end
    follow_redirect!
    assert_template 'notes/index'
    assert_not flash.empty?
    assert is_logged_in?
    # Checks that new user has the correct email address
    assert_equal User.last.email, email
  end
  
end
