class CreateLatestPersonEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :latest_person_events do |t|
      t.references :person, null: false, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.references :person_event, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
