class CreateViewLatestPersonEvents < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_latest_person_events AS
      SELECT
	      pe.*
      FROM latest_person_events lpe
	    INNER JOIN person_events pe ON lpe.person_event_id = pe.id
    SQL
  end
end
