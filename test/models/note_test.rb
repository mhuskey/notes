require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  
  def setup
    @note = notes(:one)
  end
  
  test "should be valid" do
    assert @note.valid?
  end
  
  test "title should be present" do
    @note.title = ""
    assert_not @note.valid?
  end
  
  test "title should not be too long" do
    @note.title = "a" * 61
    assert_not @note.valid?
  end
  
end
