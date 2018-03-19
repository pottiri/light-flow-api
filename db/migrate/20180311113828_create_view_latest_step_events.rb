class CreateViewLatestStepEvents < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_latest_step_events AS
      SELECT
	      se.*
      FROM latest_step_events lse
	    INNER JOIN step_events se ON lse.step_event_id = se.id
    SQL
  end
end
