class CreateViewLatestStepEvents < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_latest_step_events AS
      SELECT
	      sh.*
      FROM latest_step_events lsh
	    INNER JOIN step_events sh ON lsh.step_event_id = sh.id
    SQL
  end
end
