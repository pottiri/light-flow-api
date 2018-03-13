class Event < ApplicationRecord
  belongs_to :person

  after_create :method_after_create
  def method_after_create
     LatestEvent.where(:person_id => self.person_id).destroy_all()
     LatestEvent.create(:person_id => self.person_id, :event_id => self.id)
  end
end
