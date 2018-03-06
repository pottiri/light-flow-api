class CurrentStepApprover < ApplicationRecord
  belongs_to :step
  belongs_to :step_approver
end
