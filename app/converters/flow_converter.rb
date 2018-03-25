# frozen_string_literal: true

# フローの変換処理
class FlowConverter
  # 戻り値用配列への変換
  def self.to_response(flow)
    rtn = { :flow => {} }
    rtn[:flow][:id] = flow.id
    rtn[:flow][:flow_name] = flow.flow_name
    rtn[:flow][:creator_key] = flow.creator_key
    rtn[:flow][:create_datetime] = flow.create_datetime
    rtn[:flow][:application_datetime] = flow.application_datetime
    rtn[:flow][:archive_datetime] = flow.archive_datetime
    rtn[:flow][:flow_status] = flow.flow_status
    rtn[:flow][:active_step_order] = flow.step_order
    rtn[:flow][:active_step_name] = flow.step_name
    rtn[:flow][:active_step_class] =
      StepConverter.class_code_to_name(flow.step_class)
    rtn[:flow][:active_step_status] = flow.step_status
    rtn[:flow][:step] = []
    flow.view_step_statuses.each do |step|
      rtn[:flow][:step] << StepConverter.to_response(step)
    end
    rtn
  end
end
