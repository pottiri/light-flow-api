class CurrentApproveHistory < ApplicationRecord
  belongs_to :approver
  belongs_to :approve_history
end
