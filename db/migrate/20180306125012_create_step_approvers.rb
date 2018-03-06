class CreateStepApprovers < ActiveRecord::Migration[5.1]
  def change
    create_table :step_approvers do |t|
      t.references :step, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
