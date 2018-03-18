class LatestPersonEvent < ApplicationRecord
  belongs_to :person
  belongs_to :person_event
end
