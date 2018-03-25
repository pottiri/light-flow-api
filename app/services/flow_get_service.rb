# frozen_string_literal: true

# フローの取得処理
class FlowGetService
  def initialize; end

  # 取得
  def get(id)
    flow = ViewFlowStatus
           .includes(
             view_step_statuses: [
               view_person_statuses: [
                 :person_events
               ]
             ]
           )
           .where(id: id).first
    return nil if flow.nil?
    FlowConverter.to_response(flow)
  end
end
