class ViewLatestEvents < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_latest_events AS
      SELECT
	      e.*
      FROM latest_events le
	    INNER JOIN events e ON le.event_id = e.id
    SQL
  end
end
