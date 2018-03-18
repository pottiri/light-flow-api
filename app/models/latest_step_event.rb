class LatestStepEvent < ApplicationRecord
  belongs_to :step
  belongs_to :step_event
end
