class Step < ApplicationRecord
  belongs_to :flow
  has_many :step_histories
  has_many :latest_step_histories
end
