class CreateLatestEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :latest_events do |t|
      t.references :person, :null => false, foreign_key: {on_delete: :cascade}
      t.references :event, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
    
    add_index :latest_events, [:person_id, :event_id], :unique => true

  end
end
