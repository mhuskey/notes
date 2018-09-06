require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Notes App"
    @user       = users(:matt)
    @other_user = users(:bob)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up" + " | #{@base_title}"
  end
  
  test "should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
    assert_select "title", "Edit User" + " | #{@base_title}"
  end
  
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to user_notes_path(@other_user)
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { email: @user.email } }
    assert flash.empty?
    assert_redirected_to user_notes_path(@other_user)
  end
  
end
