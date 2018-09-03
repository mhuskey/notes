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
  
  test "should create note" do
    title = "New Note"
    content = "Lorem ipsum..."
    assert_difference 'Note.count' do
      post user_notes_path(@user), params: { note: { title: title, content: content } }
    end
    assert_redirected_to user_notes_path
    assert_not flash.empty?
    new_note = @user.notes.last
    assert_equal new_note.title, title
    assert_equal new_note.content, content
  end
  
  test "should update note" do
    title = "New Note"
    content = "Lorem ipsum..."
    patch user_note_path(@user, @note), params: { note: { title: title, content: content } }
    assert_redirected_to user_note_path
    assert_not flash.empty?
    @note.reload
    assert_equal @note.title, title
    assert_equal @note.content, content
    # Check that the title of the page is updated to the new title
    get user_note_path
    assert_select "title", "#{title}" + " | #{@base_title}"
  end
  
  test "should destroy note" do
    assert_difference 'Note.count', -1 do
      delete user_note_path(@user, @note)
    end
    assert_redirected_to user_notes_path
    assert_not flash.empty?
  end
  
end
