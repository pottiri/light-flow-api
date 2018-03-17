require 'test_helper'

class FlowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_test_flow()
  end

  test "should get index" do
    get flows_url, as: :json
    assert_response :success
  end

  # test "should create flow" do
  #   assert_difference('Flow.count') do
  #     post flows_url, params: { flow: { meta: @flow.meta } }, as: :json
  #   end

  #   assert_response 201
  # end

  # test "should show flow" do
  #   get flow_url(@flow), as: :json
  #   assert_response :success
  # end

  # test "should update flow" do
  #   patch flow_url(@flow), params: { flow: { meta: @flow.meta } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy flow" do
  #   assert_difference('Flow.count', -1) do
  #     delete flow_url(@flow), as: :json
  #   end

  #   assert_response 204
  # end
end
