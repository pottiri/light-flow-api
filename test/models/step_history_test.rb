require 'test_helper'

class StepHistoryTest < ActiveSupport::TestCase
  setup do
    create_test_flow
  end

  test 'ステップ履歴を追加すると、最新履歴を示すレコードが更新されること' do
    flow = ViewFlowStatus.includes(:view_step_statuses).where(id: flows(:flow_draft).id).first
    Rails.logger.debug(flow.view_step_statuses[0].to_yaml)
    step_id = flow.view_step_statuses[0].id
    step_history_id = StepHistory.create(operator: Settings.operator.and, step_id: step_id)
    assert_equal 1, LatestStepHistory.where(step_id: step_id, step_history_id: step_history_id).count
  end
end
