ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here..

  def create_test_flow
    # テストデータの作成
    # 申請前のフロー
    1.times do |_n|
      flow = flows(:flow_draft)
      step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
      person.events.create(event_class: Settings.event_class.create)

      step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 2)
      person = step_history.people.create(person_id: 3)

      step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 4)
      person = step_history.people.create(person_id: 5)

      step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.or)
      person = step_history.people.create(person_id: 6)
      person = step_history.people.create(person_id: 7)

      step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
    end

    # 一次承認待ちのフロー
    1.times do |_n|
      flow = flows(:flow_active_approve_and)
      step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
      person.events.create(event_class: Settings.event_class.create)
      person.events.create(event_class: Settings.event_class.application)

      step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 2)
      person.events.create(event_class: Settings.event_class.approve_request)
      person = step_history.people.create(person_id: 3)
      person.events.create(event_class: Settings.event_class.approve_request)

      step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 4)
      person = step_history.people.create(person_id: 5)

      step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.or)
      person = step_history.people.create(person_id: 6)
      person = step_history.people.create(person_id: 7)

      step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
    end

    # 二次承認待ち（OR）のフロー
    1.times do |_n|
      flow = flows(:flow_active_approve_or)
      step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
      person.events.create(event_class: Settings.event_class.create)
      person.events.create(event_class: Settings.event_class.application)

      step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 2)
      person.events.create(event_class: Settings.event_class.approve)
      person = step_history.people.create(person_id: 3)
      person.events.create(event_class: Settings.event_class.approve)

      step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 4)
      person.events.create(event_class: Settings.event_class.confirm_request)
      person = step_history.people.create(person_id: 5)
      person.events.create(event_class: Settings.event_class.confirm)

      step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.or)
      person = step_history.people.create(person_id: 6)
      person.events.create(event_class: Settings.event_class.approve_request)
      person = step_history.people.create(person_id: 7)
      person.events.create(event_class: Settings.event_class.approve_request)

      step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
    end

    # 完了したフロー
    1.times do |_n|
      flow = flows(:flow_finish)
      step = flow.steps.create(step_num: Settings.step_num.create, step_class: Settings.step_class.create)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
      person.events.create(event_class: Settings.event_class.create)
      person.events.create(event_class: Settings.event_class.application)

      step = flow.steps.create(step_num: 1, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 2)
      person.events.create(event_class: Settings.event_class.approve)
      person = step_history.people.create(person_id: 3)
      person.events.create(event_class: Settings.event_class.approve)

      step = flow.steps.create(step_num: 2, step_class: Settings.step_class.confirm)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 4)
      person.events.create(event_class: Settings.event_class.confirm)
      person = step_history.people.create(person_id: 5)
      person.events.create(event_class: Settings.event_class.confirm)

      step = flow.steps.create(step_num: 3, step_class: Settings.step_class.approve)
      step_history = step.step_histories.create(operator: Settings.operator.or)
      person = step_history.people.create(person_id: 6)
      person.events.create(event_class: Settings.event_class.approve)
      person = step_history.people.create(person_id: 7)
      person.events.create(event_class: Settings.event_class.skip)

      step = flow.steps.create(step_num: Settings.step_num.archive, step_class: Settings.step_class.archive)
      step_history = step.step_histories.create(operator: Settings.operator.and)
      person = step_history.people.create(person_id: 1)
      person.events.create(event_class: Settings.event_class.archive)
    end
  end
end
