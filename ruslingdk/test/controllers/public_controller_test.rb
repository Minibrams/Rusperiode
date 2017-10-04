require 'test_helper'

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get contacts" do
    get public_contacts_url
    assert_response :success
  end

  test "should get calendar" do
    get public_calendar_url
    assert_response :success
  end

end
