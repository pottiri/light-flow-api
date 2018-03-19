class CreatePersonEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :person_events do |t|
      t.integer :person_event_class, null: false, comment: 'イベント区分'
      t.text :comment, commnet: 'コメント'
      t.references :person, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :person_events, %i[person_id person_event_class]
  end
end
