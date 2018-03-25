# frozen_string_literal: true

# 担当者の変換処理
class PersonConverter
  @event_class_options = {
    Settings.person_event_class.create => 'create',
    Settings.person_event_class.application => 'application',
    Settings.person_event_class.rejected => 'rejected',
    Settings.person_event_class.approve_request => 'approve_request',
    Settings.person_event_class.approve => 'approve',
    Settings.person_event_class.reject => 'reject',
    Settings.person_event_class.rejected => 'rejected',
    Settings.person_event_class.skip => 'skip',
    Settings.person_event_class.confirm_request => 'confirm_request',
    Settings.person_event_class.confirm => 'confirm',
    Settings.person_event_class.skip_backward => 'skip_backward',
    Settings.person_event_class.archive => 'archive'
  }
  # 戻り値用配列への変換
  def self.to_response(person)
    rtn = {}
    rtn[:person_key] = person.person_key
    rtn[:person_status] = person.person_status
    rtn[:person_event] = []
    person.person_events.each do |person_event|
      rtn[:person_event] << {
        'person_event_class' => event_class_code_to_name(
          person_event.person_event_class
        ),
        'person_event_datetime' => person_event.created_at,
        'person_event_comment' => person_event.comment
      }
    end
    rtn
  end

  # イベント区分の変換(コード→名前)
  def self.event_class_code_to_name(code)
    @event_class_options[code]
  end
end
