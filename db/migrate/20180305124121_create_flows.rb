class CreateFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :flows do |t|
      t.string :flow_name, null: false
      t.string :creator_key
      t.json :meta
      t.datetime :create_datetime
      t.datetime :application_datetime
      t.datetime :archive_datetime

      t.timestamps
    end
  end
end
