# frozen_string_literal: true

class Flow < ApplicationRecord
  has_many :steps
end
