class CreateStepEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :step_events do |t|
      t.integer :step_order, null: false, default: 0, comment: '実行順'
      t.string :step_name, null: false, comment: '名称'
      t.integer :step_operator, null: false, comment: '演算子(10:AND,20:OR)'
      t.integer :step_event_class, null: false, comment: 'イベント区分'
      t.references :step, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
