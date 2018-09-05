require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Notes App"
    @note       = notes(:one)
    @user       = users(:matt)
  end
  
  test "should get index" do
    get user_notes_path(@user)
    assert_response :success
    assert_select "title", "All Notes" + " | #{@base_title}"
  end
  
  test "should get show" do
    get user_note_path(@user, @note)
    assert_response :success
    assert_select "title", "#{@note.title}" + " | #{@base_title}"
  end
  
  test "should get new" do
    get new_user_note_path(@user, @note)
    assert_response :success
    assert_select "title", "New Note" + " | #{@base_title}"
  end
  
  test "should get edit" do
    get edit_user_note_path(@user, @note)
    assert_response :success
    assert_select "title", "Edit Note" + " | #{@base_title}"
  end
  
end
