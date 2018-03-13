class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.integer :step_num, :null => false, :commnet => 'ステップNo'
      t.integer :step_class, :null => false, :comment => 'ステップ区分(10:開始,20:承認,30:配信,90:終了)'
      t.references :flow, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
    
    add_index :steps, [:flow_id, :step_class]
    add_index :steps, [:flow_id, :step_num], :unique => true
    
  end
end
