class CreateCurrentStepApprovers < ActiveRecord::Migration[5.1]
  def change
    create_table :current_step_approvers do |t|
      t.references :step, :null => false, foreign_key: {on_delete: :cascade}
      t.references :step_approver, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
