# frozen_string_literal: true

class Step < ApplicationRecord
  belongs_to :flow
  has_many :step_events
end
