class ViewLatestStepEvent < ApplicationRecord
  belongs_to :step, foreign_key: 'step_id'
  has_many :people, primary_key: 'id', foreign_key: 'step_event_id'
end
