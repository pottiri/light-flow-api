class Person < ApplicationRecord
  belongs_to :step_event
  has_many :events
  has_one :latest_events
  has_one :view_latest_events, primary_key: 'id', foreign_key: 'person_id'
end
