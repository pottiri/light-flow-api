# frozen_string_literal: true

class ViewStepStatus < ApplicationRecord
  belongs_to :view_flow_statuses, foreign_key: 'flow_id'
  has_many :view_person_statuses, primary_key: 'step_event_id', foreign_key: 'step_event_id'
end
