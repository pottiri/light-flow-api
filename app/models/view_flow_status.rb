# frozen_string_literal: true

# ステータス付きフローモデル
class ViewFlowStatus < ApplicationRecord
  has_many :view_step_statuses, primary_key: 'id', foreign_key: 'flow_id'
end
