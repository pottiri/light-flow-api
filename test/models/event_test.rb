require 'test_helper'

class EventTest < ActiveSupport::TestCase
  setup do
    create_test_flow
  end

  test 'フローの作成日時が入っていること' do
    flow = Flow.find(flows(:flow_draft).id)
    assert !flow.create_datetime.nil?
  end
  test 'フローの申請日時が入っていること' do
    flow = Flow.find(flows(:flow_active_approve_and).id)
    assert !flow.application_datetime.nil?
  end
  test 'フローの保管日時が入っていること' do
    flow = Flow.find(flows(:flow_finish).id)
    assert !flow.archive_datetime.nil?
  end
end
