class StepEvent < ApplicationRecord
  belongs_to :step
  has_many :people
  
  after_create :method_after_create
  def method_after_create
    LatestStepEvent.where(:step_id => self.step_id).destroy_all()
    LatestStepEvent.create(:step_id => self.step_id, :step_event_id => self.id)
  end
  
end
