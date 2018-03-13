class Person < ApplicationRecord
  belongs_to :step_history
  has_many :events
  has_one :latest_events
end
