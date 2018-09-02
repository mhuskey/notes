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
  
  test "should create user" do
    email = "user@example.com"
    assert_difference 'User.count' do
      post users_path, params: { user: { email: email, password: "foobar", password_confirmation: "foobar" } }
    end
    assert_redirected_to root_path
    assert_not flash.empty?
    new_user = User.last
    assert_equal new_user.email, email
  end
  
  test "should edit user" do
    email = "matthew@example.com"
    patch user_path(@user), params: { user: { email: email, password: "foobar1", password_confirmation: "foobar1" } }
    assert_redirected_to root_path
    assert_not flash.empty?
    @user.reload
    assert_equal @user.email, email
  end
  
end
