class PersonEvent < ApplicationRecord
  belongs_to :person

  after_create :method_after_create
  def method_after_create
    LatestPersonEvent.where(person_id: person_id).destroy_all
    LatestPersonEvent.create(person_id: person_id, person_event_id: id)

    # 作成、申請、保管の場合はフローの該当日付を更新する
    if Settings.person_event_class.create != person_event_class &&
       Settings.person_event_class.application != person_event_class &&
       Settings.person_event_class.archive != person_event_class
      return
    end

    flow = Flow.find(person.step_event.step.flow.id)
    case person_event_class
    when Settings.person_event_class.create then
      flow.create_datetime = created_at
    when Settings.person_event_class.application then
      flow.application_datetime = created_at
    when Settings.person_event_class.archive then
      flow.archive_datetime = created_at
    end
    flow.save
  end
end
