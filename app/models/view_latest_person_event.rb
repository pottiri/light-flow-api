class ViewLatestPersonEvent < ApplicationRecord
  belongs_to :people, foreign_key: 'person_id'
end
