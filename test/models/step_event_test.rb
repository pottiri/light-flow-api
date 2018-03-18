require 'test_helper'

class StepEventTest < ActiveSupport::TestCase
  setup do
    create_test_flow
  end

  test 'ステップ履歴を追加すると、最新履歴を示すレコードが更新されること' do
    flow = ViewFlowStatus.includes(:view_step_statuses).where(id: flows(:flow_draft).id).first
    Rails.logger.debug(flow.view_step_statuses[0].to_yaml)
    step_id = flow.view_step_statuses[0].id
    step_event_id = StepEvent.create(operator: Settings.operator.and, step_id: step_id)
    assert_equal 1, LatestStepEvent.where(step_id: step_id, step_event_id: step_event_id).count
  end
end
