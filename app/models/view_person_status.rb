# frozen_string_literal: true

# ステータス付き担当者モデル
class ViewPersonStatus < ApplicationRecord
  self.primary_key = :id
  belongs_to :view_step_statuses, foreign_key: 'step_event_id'
  has_many :person_events, primary_key: 'id', foreign_key: 'person_id'
end
