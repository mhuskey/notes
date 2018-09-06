require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:matt)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    email                 = "user@invalid"
    password              = "foo"
    password_confirmation = "bar"
    patch user_path(@user), params: { user: { email: email, password: password, password_confirmation: password_confirmation } }
    assert_template 'users/edit'
    @user.reload
    assert_not_equal @user.email, email
  end
  
  test "successful edit" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to user_notes_url(@user)
    email                 = "matthew@example.com"
    password              = "foobar"
    password_confirmation = "foobar"
    patch user_path(@user), params: { user: { email: email, password: password, password_confirmation: password_confirmation } }
    assert_redirected_to user_notes_url(@user)
    assert_not flash.empty?
    @user.reload
    assert_equal @user.email, email
  end
  
end
