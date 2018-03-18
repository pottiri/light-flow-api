# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.create)

# 申請前のフロー
1.times do |_n|
  flow = Flow.create(creator_key: 1)
  step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
  person.events.create(event_class: Settings.event_class.create)

  step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 2)
  person = step_event.people.create(person_key: 3)

  step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 4)
  person = step_event.people.create(person_key: 5)

  step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.or)
  person = step_event.people.create(person_key: 6)
  person = step_event.people.create(person_key: 7)

  step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
end

# 一次承認待ちのフロー
1.times do |_n|
  flow = Flow.create(creator_key: 1)
  step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
  person.events.create(event_class: Settings.event_class.create)
  person.events.create(event_class: Settings.event_class.application)

  step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 2)
  person.events.create(event_class: Settings.event_class.approve_request)
  person = step_event.people.create(person_key: 3)
  person.events.create(event_class: Settings.event_class.approve_request)

  step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 4)
  person = step_event.people.create(person_key: 5)

  step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.or)
  person = step_event.people.create(person_key: 6)
  person = step_event.people.create(person_key: 7)

  step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
end

# 二次承認待ち（OR）のフロー
1.times do |_n|
  flow = Flow.create(creator_key: 1)
  step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
  person.events.create(event_class: Settings.event_class.create)
  person.events.create(event_class: Settings.event_class.application)

  step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 2)
  person.events.create(event_class: Settings.event_class.approve)
  person = step_event.people.create(person_key: 3)
  person.events.create(event_class: Settings.event_class.approve)

  step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 4)
  person.events.create(event_class: Settings.event_class.confirm_request)
  person = step_event.people.create(person_key: 5)
  person.events.create(event_class: Settings.event_class.confirm)

  step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.or)
  person = step_event.people.create(person_key: 6)
  person.events.create(event_class: Settings.event_class.approve_request)
  person = step_event.people.create(person_key: 7)
  person.events.create(event_class: Settings.event_class.approve_request)

  step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
end

# 完了したフロー
1.times do |_n|
  flow = Flow.create(creator_key: 1)
  step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
  person.events.create(event_class: Settings.event_class.create)
  person.events.create(event_class: Settings.event_class.application)

  step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 2)
  person.events.create(event_class: Settings.event_class.approve)
  person = step_event.people.create(person_key: 3)
  person.events.create(event_class: Settings.event_class.approve)

  step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 4)
  person.events.create(event_class: Settings.event_class.confirm)
  person = step_event.people.create(person_key: 5)
  person.events.create(event_class: Settings.event_class.confirm)

  step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
  step_event = step.step_events.create(operator: Settings.operator.or)
  person = step_event.people.create(person_key: 6)
  person.events.create(event_class: Settings.event_class.approve)
  person = step_event.people.create(person_key: 7)
  person.events.create(event_class: Settings.event_class.skip)

  step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
  step_event = step.step_events.create(operator: Settings.operator.and)
  person = step_event.people.create(person_key: 1)
  person.events.create(event_class: Settings.event_class.archive)
end
