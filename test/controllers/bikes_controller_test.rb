require "test_helper"

class BikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bike = bikes(:one)
  end

  test "should get index" do
    get bikes_url, as: :json
    assert_response :success
  end

  test "should create bike" do
    assert_difference("Bike.count") do
      post bikes_url, params: { bike: { model: @bike.model, name: @bike.name } }, as: :json
    end

    assert_response :created
  end

  test "should show bike" do
    get bike_url(@bike), as: :json
    assert_response :success
  end

  test "should update bike" do
    patch bike_url(@bike), params: { bike: { model: @bike.model, name: @bike.name } }, as: :json
    assert_response :success
  end

  test "should destroy bike" do
    assert_difference("Bike.count", -1) do
      delete bike_url(@bike), as: :json
    end

    assert_response :no_content
  end
end
