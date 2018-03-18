class Step < ApplicationRecord
  belongs_to :flow
  has_many :step_events
  has_one :latest_step_events
  has_one :view_latest_step_events, primary_key: 'id', foreign_key: 'step_id'
end
