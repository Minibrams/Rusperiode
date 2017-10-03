require 'test_helper'

class MemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get memes_url
    assert_response :success
  end

  test "should get show" do
    get meme_url(1)
    assert_response :success
  end

end
