# frozen_string_literal: true

# フローの作成処理
class FlowCreateService
  def initialize; end

  # 作成
  def create(params)
    flow = Flow.create(
      flow_name: params['flow']['flow_name'],
      creator_key: params['flow']['creator_key']
    )
    create_create_step(params['flow']['creator_key'], flow)
    params['flow']['step'].each do |params_step|
      create_step(params_step, flow)
    end
    create_archive_step(params['flow']['creator_key'], flow)
    flow
  end

  # 作成ステップの登録
  def create_create_step(creator_key, flow)
    params = {}
    params['step_class'] = 'create'
    params['step_order'] = Settings.step_order.create
    params['step_name'] = 'Create'
    params['step_operator'] = 'and'
    params['person'] = [
      { 'person_key' => creator_key }
    ]
    create_step(params, flow, true)
  end

  # 保管ステップの登録
  def create_archive_step(creator_key, flow)
    params = {}
    params['step_class'] = 'archive'
    params['step_order'] = Settings.step_order.archive
    params['step_name'] = 'Archive'
    params['step_operator'] = 'and'
    params['person'] = [
      { 'person_key' => creator_key }
    ]
    create_step(params, flow)
  end

  # ステップイベントの作成
  def create_step(params, flow, create_person_event = false)
    step = flow.steps.create(
      step_class: StepConverter.class_name_to_code(params['step_class'])
    )
    step_event = step.step_events.create(
      step_order: params['step_class'],
      step_name: params['step_name'],
      step_operator: StepConverter.operator_name_to_code(
        params['step_operator']
      ),
      step_event_class: Settings.step_event_class.create
    )
    params['person'].each do |params_person|
      person = step_event.people.create(
        person_key: params_person['person_key']
      )
      next unless create_person_event
      person.person_events.create(
        person_event_class: Settings.person_event_class.create
      )
    end
  end
end
