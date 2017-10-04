require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get knoldbold" do
    get events_knoldbold_url
    assert_response :success
  end

  test "should get pubcrawl" do
    get events_pubcrawl_url
    assert_response :success
  end

  test "should get lan" do
    get events_lan_url
    assert_response :success
  end

  test "should get ruskursus" do
    get events_ruskursus_url
    assert_response :success
  end

  test "should get boardgame" do
    get events_boardgame_url
    assert_response :success
  end

  test "should get latex" do
    get events_latex_url
    assert_response :success
  end

end
