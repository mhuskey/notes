require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Notes App"
    @user       = users(:matt)
    @other_user = users(:bob)
    @note       = notes(:one)
  end
  
  test "should get index" do
    log_in_as(@user)
    get user_notes_path(@user)
    assert_response :success
    assert_select "title", "All Notes" + " | #{@base_title}"
  end
  
  test "should get show" do
    log_in_as(@user)
    get user_note_path(@user, @note)
    assert_response :success
    assert_select "title", "#{@note.title}" + " | #{@base_title}"
  end
  
  test "should get new" do
    log_in_as(@user)
    get new_user_note_path(@user, @note)
    assert_response :success
    assert_select "title", "New Note" + " | #{@base_title}"
  end
  
  test "should get edit" do
    log_in_as(@user)
    get edit_user_note_path(@user, @note)
    assert_response :success
    assert_select "title", "Edit Note" + " | #{@base_title}"
  end
  
  test "should redirect index when not logged in" do
    get user_notes_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect show when not logged in" do
    get user_note_path(@user, @note)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect new when not logged in" do
    get new_user_note_path(@user, @note)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when not logged in" do
    get edit_user_note_path(@user, @note)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect new when logged in as wrong user" do
    log_in_as(@other_user)
    get new_user_note_path(@user, @note)
    assert flash.empty?
    assert_redirected_to user_notes_path(@other_user)
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { note: { title: "New Title" } }
    assert flash.empty?
    assert_redirected_to user_notes_path(@other_user)
  end
  
  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'Note.count' do
      delete user_note_path(@user, @note)
    end
    assert flash.empty?
    assert_redirected_to user_notes_path(@other_user)
  end
  
end
