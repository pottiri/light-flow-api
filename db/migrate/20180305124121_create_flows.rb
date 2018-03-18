class CreateFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :flows do |t|
      t.integer :creator_key
      t.json :meta
      t.datetime :create_datetime
      t.datetime :application_datetime
      t.datetime :archive_datetime

      t.timestamps
    end
  end
end
