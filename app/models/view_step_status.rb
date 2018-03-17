class ViewStepStatus < ApplicationRecord
  belongs_to :view_flow_statuses, foreign_key: 'flow_id'
end
