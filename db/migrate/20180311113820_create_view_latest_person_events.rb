class CreateViewLatestPersonEvents < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_latest_person_events AS
      SELECT
	      e.*
      FROM latest_person_events le
	    INNER JOIN person_events e ON le.person_event_id = e.id
    SQL
  end
end
