# frozen_string_literal: true

# ステップの変換処理
class StepConverter
  @class_options = {
    Settings.step_class.create => 'create',
    Settings.step_class.approve => 'approve',
    Settings.step_class.confirm => 'confirm',
    Settings.step_class.archive => 'archive'
  }
  @operator_options = {
    Settings.step_operator.and => 'and',
    Settings.step_operator.or => 'or'
  }

  # 戻り値用配列への変換
  def self.to_response(step)
    rtn = {}
    rtn[:id] = step.id
    rtn[:step_order] = step.step_order
    rtn[:step_name] = step.step_name
    rtn[:step_class] =
      class_code_to_name(step.step_class)
    rtn[:step_operator] =
      operator_code_to_name(step.step_operator)
    rtn[:person] = []
    step.view_person_statuses.each do |person|
      rtn[:person] << PersonConverter.to_response(person)
    end
    rtn
  end

  # 区分の変換(名前→コード)
  def self.class_name_to_code(name)
    @class_options.key(name)
  end

  # 区分の変換(コード→名前)
  def self.class_code_to_name(code)
    @class_options[code]
  end

  # 演算子の変換(名前→コード)
  def self.operator_name_to_code(name)
    @operator_options.key(name)
  end

  # 演算子の変換(コード→名前)
  def self.operator_code_to_name(code)
    @operator_options[code]
  end
end
