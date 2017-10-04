require 'test_helper'

class FaqControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get faq_index_url
    assert_response :success
  end

  test "should get studystart" do
    get faq_studystart_url
    assert_response :success
  end

  test "should get exam" do
    get faq_exam_url
    assert_response :success
  end

  test "should get study" do
    get faq_study_url
    assert_response :success
  end

end
