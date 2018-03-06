class CreateFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :flows do |t|
      t.json :meta

      t.timestamps
    end
  end
end
