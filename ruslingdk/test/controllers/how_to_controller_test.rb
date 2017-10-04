require 'test_helper'

class HowToControllerTest < ActionDispatch::IntegrationTest
  test "should get latex" do
    get how_to_latex_url
    assert_response :success
  end

  test "should get wifi" do
    get how_to_wifi_url
    assert_response :success
  end

  test "should get student_card" do
    get how_to_student_card_url
    assert_response :success
  end

  test "should get printer" do
    get how_to_printer_url
    assert_response :success
  end

  test "should get schedule" do
    get how_to_schedule_url
    assert_response :success
  end

  test "should get student_mail" do
    get how_to_student_mail_url
    assert_response :success
  end

  test "should get moodle" do
    get how_to_moodle_url
    assert_response :success
  end

end
