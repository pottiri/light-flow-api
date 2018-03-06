class CreateApprovers < ActiveRecord::Migration[5.1]
  def change
    create_table :approvers do |t|
      t.string :user_id, :null => false, :commnet => 'ユーザID'
      t.references :step_approver, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
