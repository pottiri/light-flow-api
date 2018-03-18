class CreateLatestStepEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :latest_step_events do |t|
      t.references :step, null: false, index: { unique: true }, foreign_key: { on_delete: :cascade }
      t.references :step_event, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
