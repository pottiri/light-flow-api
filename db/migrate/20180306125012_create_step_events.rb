class CreateStepEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :step_events do |t|
      t.integer :operator, :null => false, :comment => '演算子(10:AND,20:OR)'
      t.references :step, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
