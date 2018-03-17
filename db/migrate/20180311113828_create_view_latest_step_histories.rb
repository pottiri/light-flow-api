class CreateViewLatestStepHistories < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_latest_step_histories AS
      SELECT
	      sh.*
      FROM latest_step_histories lsh
	    INNER JOIN step_histories sh ON lsh.step_history_id = sh.id
    SQL
  end
end
