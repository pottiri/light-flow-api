class StepHistory < ApplicationRecord
  belongs_to :step
  has_many :people
  
  after_create :method_after_create
  def method_after_create
    LatestStepHistory.where(:step_id => self.step_id).destroy_all()
    LatestStepHistory.create(:step_id => self.step_id, :step_history_id => self.id)
  end
  
end
