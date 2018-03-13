class LatestStepHistory < ApplicationRecord
  belongs_to :step
  belongs_to :step_history
end
