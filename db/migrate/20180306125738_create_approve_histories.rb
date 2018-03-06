class CreateApproveHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :approve_histories do |t|
      t.integer :status, :null => false, :comment => 'ステータス(0:未実行,10:実行中,20:実行済,30:棄却,40:前方スキップ,41:後方スキップ)'
      t.text :comment, :commnet => 'コメント'
      t.references :approver, :null => false, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
