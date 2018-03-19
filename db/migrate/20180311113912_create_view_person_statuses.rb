class CreateViewPersonStatuses < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_person_statuses AS
      SELECT
	      p.*,
        vlpe.person_event_class,
	      vlpe.comment,
        (vlpe.person_event_class IS NULL
         OR vlpe.person_event_class = 800
        ) as none_flag,
        (vlpe.person_event_class = 100
         OR vlpe.person_event_class = 200
         OR vlpe.person_event_class = 300
         OR vlpe.person_event_class = 900
        ) as active_flag,
        (vlpe.person_event_class = 110
         OR vlpe.person_event_class = 210
         OR vlpe.person_event_class = 240
         OR vlpe.person_event_class = 310
        ) as finish_flag,
        (vlpe.person_event_class = 220) as reject_flag,
        (vlpe.person_event_class = 120
         OR vlpe.person_event_class = 230) as rejected_flag,
        (CASE
 	       WHEN (vlpe.person_event_class IS NULL
               OR vlpe.person_event_class = 800
              ) THEN 'none'
         WHEN (vlpe.person_event_class = 100
               OR vlpe.person_event_class = 200
               OR vlpe.person_event_class = 300
               OR vlpe.person_event_class = 900
             ) THEN 'active'
         WHEN (vlpe.person_event_class = 110
               OR vlpe.person_event_class = 210
               OR vlpe.person_event_class = 240
               OR vlpe.person_event_class = 310
             ) THEN 'finish'
         WHEN (vlpe.person_event_class = 220) THEN 'none'
         WHEN (vlpe.person_event_class = 120
               OR vlpe.person_event_class = 230) THEN 'active'
 	       ELSE 'none'
         END) as person_status
      FROM people p
	    LEFT JOIN view_latest_person_events vlpe ON p.id = vlpe.person_id
    SQL
  end
end
