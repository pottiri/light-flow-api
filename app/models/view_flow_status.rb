class ViewFlowStatus < ApplicationRecord
  has_many :view_step_statuses, primary_key: 'id', foreign_key: 'flow_id'
end
