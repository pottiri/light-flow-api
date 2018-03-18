class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :person_key, null: false, commnet: 'ユーザキー'
      t.references :step_event, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :people, %i[step_event_id person_key], unique: true
  end
end
