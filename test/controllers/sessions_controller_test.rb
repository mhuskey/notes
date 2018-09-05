require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "Notes App"
  end
  
  test "should get new" do
    get login_path
    assert_response :success
    assert_select "title", "Log in" + " | #{@base_title}"
  end
  
end
