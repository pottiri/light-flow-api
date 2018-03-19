require 'test_helper'

class FlowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_test_flow
  end

  test '特に条件を指定しなければ全件が返ること' do
    get flows_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 4, json_response['count']
    assert_equal 4, json_response['list'].length
  end

  test '作成者で絞りこめること' do
    get flows_url + '?' + { 'creator_key' => 1 }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response['count']
    assert_equal 2, json_response['list'].length
  end

  test '下書きのフローだけに絞りこめること' do
    get flows_url + '?' + { 'flow_status' => 'draft' }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert_equal 1, json_response['list'].length
  end

  test '実行中のフローに絞りこめること' do
    get flows_url + '?' + { 'flow_status' => 'active' }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response['count']
    assert_equal 2, json_response['list'].length
  end

  test '保管のフローだけに絞りこめること' do
    get flows_url + '?' + { 'flow_status' => 'archive' }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert_equal 1, json_response['list'].length
  end

  test '実行中のステップNoで絞りこめること' do
    get flows_url + '?' + { 'step_order' => 1 }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert_equal 1, json_response['list'].length
  end

  test '担当者IDで絞りこめること' do
    get flows_url + '?' + { 'person_key' => 8 }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response['count']
    assert_equal 2, json_response['list'].length
  end

  test '担当者のステータスで絞りこめること' do
    get flows_url + '?' + { 'person_key' => 7, 'person_status' => 'none' }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response['count']
    assert_equal 2, json_response['list'].length
    get flows_url + '?' + { 'person_key' => 7, 'person_status' => 'active' }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert_equal 1, json_response['list'].length
    get flows_url + '?' + { 'person_key' => 7, 'person_status' => 'finish' }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert_equal 1, json_response['list'].length
  end

  test '件数だけ取得できること' do
    get flows_url + '?' + { 'person_key' => 7, 'person_status' => 'none', 'count' => true }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 2, json_response['count']
    assert json_response['list'].nil?
    get flows_url + '?' + { 'person_key' => 7, 'person_status' => 'active', 'count' => true }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert json_response['list'].nil?
    get flows_url + '?' + { 'person_key' => 7, 'person_status' => 'finish', 'count' => true }.to_query, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response['count']
    assert json_response['list'].nil?
  end

  test 'フローが作成できること' do
    assert_difference('Flow.count') do
      post flows_url, params: { flow: { meta: @flow.meta } }, as: :json
    end

    assert_response 201
  end

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
