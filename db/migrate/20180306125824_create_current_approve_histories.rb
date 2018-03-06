class CreateCurrentApproveHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :current_approve_histories do |t|
      t.references :approver, :null => false, foreign_key: {on_delete: :cascade}
      t.references :approve_history, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
