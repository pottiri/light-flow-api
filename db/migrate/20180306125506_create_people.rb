class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :person_id, :null => false, :commnet => 'ユーザID'
      t.references :step_history, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
    
    add_index :people, [:step_history_id, :person_id], :unique => true

  end
end
