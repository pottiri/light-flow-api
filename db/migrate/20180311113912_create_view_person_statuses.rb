class CreateViewPersonStatuses < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_person_statuses AS
      SELECT
	    p.*,
        vle.person_event_class,
	    vle.comment,
        (vle.person_event_class IS NULL
         OR vle.person_event_class = 800
        ) as none_flag,
        (vle.person_event_class = 100
         OR vle.person_event_class = 200
         OR vle.person_event_class = 300
         OR vle.person_event_class = 900
        ) as active_flag,
        (vle.person_event_class = 110
         OR vle.person_event_class = 210
         OR vle.person_event_class = 240
         OR vle.person_event_class = 310
        ) as finish_flag,
        (vle.person_event_class = 220) as reject_flag,
        (vle.person_event_class = 120
         OR vle.person_event_class = 230) as rejected_flag,
        (CASE
 	       WHEN (vle.person_event_class IS NULL
               OR vle.person_event_class = 800
              ) THEN 'none'
         WHEN (vle.person_event_class = 100
               OR vle.person_event_class = 200
               OR vle.person_event_class = 300
               OR vle.person_event_class = 900
             ) THEN 'active'
         WHEN (vle.person_event_class = 110
               OR vle.person_event_class = 210
               OR vle.person_event_class = 240
               OR vle.person_event_class = 310
             ) THEN 'finish'
         WHEN (vle.person_event_class = 220) THEN 'none'
         WHEN (vle.person_event_class = 120
               OR vle.person_event_class = 230) THEN 'active'
 	       ELSE 'none'
         END) as person_status
      FROM people p
	    LEFT JOIN view_latest_person_events vle ON p.id = vle.person_id
    SQL
  end
end
