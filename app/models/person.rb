# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :step_event
  has_many :person_events
end
