require 'test_helper'

class NotesInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Notes App"
    @user       = users(:matt)
    @other_user = users(:bob)
  end
  
  test "notes interface" do
    # Try to view notes without logging in
    get user_notes_path(@user)
    follow_redirect!
    assert_template 'sessions/new'
    
    # Log in as @user
    log_in_as(@user)
    get new_user_note_path(@user, @note)
    
    # Invalid submission
    assert_no_difference 'Note.count' do
      post user_notes_path(@user), params: { note: { title: "", content: "" } }
    end
    assert_template 'notes/new'
    assert_select 'div#error_explanation'
    
    # Valid submission
    title = "New Note"
    content = "Lorem ipsum..."
    assert_difference 'Note.count' do
      post user_notes_path(@user), params: { note: { title: title, content: content } }
    end
    follow_redirect!
    assert_template 'notes/index'
    assert_not flash.empty?
    assert_equal Note.last.title, title
    assert_match title, response.body
    
    # Visit new note
    new_note = Note.last
    get user_note_path(@user, new_note)
    assert_template 'notes/show'
    assert_match title, response.body
    assert_match content, response.body
    assert_select "a[href=?]", user_notes_path
    assert_select "a[href=?]", user_note_path
    # Check page title
    assert_select "title", "#{title}" + " | #{@base_title}"
    
    # Update note
    new_title = "Edited Note"
    patch user_note_path, params: { note: { title: new_title, content: content } }
    follow_redirect!
    assert_template 'notes/show'
    assert_not flash.empty?
    assert_match new_title, response.body
    # Check page title
    assert_select "title", "#{new_title}" + " | #{@base_title}"
    
    # Delete note
    assert_select 'a', text: "Delete"
    assert_difference 'Note.count', -1 do
      delete user_note_path
    end
    follow_redirect!
    assert_template 'notes/index'
    assert_not flash.empty?
    assert_not_equal Note.last.title, title
    
    # Try to view other user's notes
    get user_notes_path(@other_user)
    follow_redirect!
    assert_template 
  end
  
end
