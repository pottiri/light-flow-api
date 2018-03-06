class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.integer :step_num, :null => false, :commnet => 'ステップNo'
      t.references :flow, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
