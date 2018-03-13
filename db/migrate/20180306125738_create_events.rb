class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :event_class, :null => false, :comment => '承認イベント'
      t.text :comment, :commnet => 'コメント'
      t.references :person, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
    
    add_index :events, [:person_id, :event_class]

  end
end
