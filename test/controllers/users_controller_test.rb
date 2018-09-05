require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Notes App"
    @user       = users(:matt)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up" + " | #{@base_title}"
  end
  
  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
    assert_select "title", "Edit User" + " | #{@base_title}"
  end
  
  test "should edit user" do
    email    = "matthew@example.com"
    password = "foobar"
    patch user_path(@user), params: { user: { email: email, password: password, password_confirmation: password } }
    assert_redirected_to root_path
    assert_not flash.empty?
    @user.reload
    assert_equal @user.email, email
  end
  
end
