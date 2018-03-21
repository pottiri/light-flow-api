require 'test_helper'

class FlowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_test_flow_all
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
      post flows_url, params: {
        flow: {
          flow_name: 'Test flow',
          creator_key: 'user_1',
          step: [
            {
              step_order: 1,
              step_name: 'Approve(AND)',
              person: [
                { person_key: 'user_2' }
              ]
            }
          ]
        }
      }, as: :json
    end
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response['message'].blank?
    assert_equal 0, json_response['errors'].length
    assert_equal 0, json_response['validation_erros'].length
    assert json_response['flow'].nil?
    assert json_response['flow_stetus'].nil?
    assert json_response['active_step_order'].nil?
    assert json_response['active_step_name'].nil?
    assert json_response['flow']['step'][0].nil?
    assert json_response['flow']['step'][0]['person'][0]['person_key'].nil?
  end

  test 'フローの作成時、子要素がない場合エラーになること' do
    post flows_url, params: {
      flow: {
        flow_name: 'Test flow',
        creator_key: 'user_1'
      }
    }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_equal 0, json_response['erros'].length
    assert_not_equal 0, json_response['validation_erros'].length

    post flows_url, params: {
      flow: {
        flow_name: 'Test flow',
        creator_key: 'user_1',
        step: [
          {
            step_order: 1,
            step_name: 'Approve(AND)'
          }
        ]
      }
    }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_equal 0, json_response['erros'].length
    assert_not_equal 0, json_response['validation_erros'].length
  end

  test 'フローの作成時、必須項目がない場合エラーになること' do
    post flows_url, params: {
      flow: {
        step: [
          {
            person: [
              {}
            ]
          }
        ]
      }
    }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_equal 0, json_response['erros'].length
    assert_not_equal 0, json_response['validation_erros'].length
  end

  test 'フローの詳細が取得できること' do
    get flow_url(:flow_draft), as: :json
    json_response = JSON.parse(response.body)
    assert json_response['flow'].nil?
    assert json_response['flow_stetus'].nil?
    assert json_response['active_step_order'].nil?
    assert json_response['active_step_name'].nil?
    assert json_response['flow']['step'][0].nil?
    assert json_response['flow']['step'][0]['person'][0]['person_key'].nil?
  end

  test 'フローの更新ができること' do
    patch flow_url(:flow_draft), params: {
      flow: {
        flow_name: 'Test flow',
        creator_key: 'user_1',
        step: [
          {
            step_order: 1,
            step_name: 'Approve(AND)',
            person: [
              { person_key: 'user_2' }
            ]
          }
        ]
      }
    }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert json_response['message'].blank?
    assert_equal 0, json_response['errors'].length
    assert_equal 0, json_response['validation_erros'].length
    assert json_response['flow'].nil?
    assert json_response['flow_stetus'].nil?
    assert json_response['active_step_order'].nil?
    assert json_response['active_step_name'].nil?
    assert json_response['flow']['step'][1].nil?
    assert_equal 'user_2', json_response['flow']['step'][1]['person'][0]['person_key']
    flow = ViewFlowStatus
           .includes(view_step_statuses: :view_person_statuses)
           .where(id: flows(:flow_draft).id).first
    assert_equal 'user_2', flow.step[1].person[0].person_key
  end

  test '実行中の場合、更新ができないこと' do
    patch flow_url(:flow_active_approve_and), params: {
      flow: {
        flow_name: 'Test flow',
        creator_key: 'user_1',
        step: [
          {
            step_order: 1,
            step_name: 'Approve(AND)',
            person: [
              { person_key: 'user_2' }
            ]
          }
        ]
      }
    }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_not_equal 0, json_response['erros'].length
  end

  test 'フローの本体だけの更新ができること' do
    patch flow_url(:flow_draft), params: {
      flow: {
        flow_name: 'Test flow2',
        creator_key: 'user_2'
      }
    }, as: :json
    assert_response :success
  end

  # test "should destroy flow" do
  #   assert_difference('Flow.count', -1) do
  #     delete flow_url(@flow), as: :json
  #   end

  #   assert_response 204
  # end
end
