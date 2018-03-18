class Event < ApplicationRecord
  belongs_to :person

  after_create :method_after_create
  def method_after_create
    LatestEvent.where(person_id: person_id).destroy_all
    LatestEvent.create(person_id: person_id, event_id: id)

    # 作成、申請、保管の場合はフローの該当日付を更新する
    if Settings.event_class.create != event_class &&
       Settings.event_class.application != event_class &&
       Settings.event_class.archive != event_class
      return
    end

    flow = Flow.find(person.step_event.step.flow.id)
    case event_class
    when Settings.event_class.create then
      flow.create_datetime = created_at
    when Settings.event_class.application then
      flow.application_datetime = created_at
    when Settings.event_class.archive then
      flow.archive_datetime = created_at
    end
    flow.save
  end
end
