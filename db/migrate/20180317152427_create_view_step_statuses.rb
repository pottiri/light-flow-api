class CreateViewStepStatuses < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_step_statuses AS
      SELECT
        s.id,
        s.flow_id,
        s.step_class,
        vlse.id as step_event_id,
        vlse.step_name,
        vlse.step_order,
        vlse.step_operator,
        (CASE
	        WHEN (s.step_class IN (10, 20, 90) AND 0 < SUM(vps.active_flag)) THEN 'active'
	        WHEN (s.step_class = 10 AND COUNT(1) <= SUM(vps.finish_flag)) THEN 'finish'
          WHEN (s.step_class = 10 AND 0 < SUM(vps.rejected_flag)) THEN 'rejected'
          WHEN (s.step_class = 20 AND 0 < SUM(vps.reject_flag)) THEN 'reject'
          WHEN (s.step_class = 20 AND 0 < SUM(vps.rejected_flag)) THEN 'active'
	        WHEN (s.step_class = 20 AND vlse.step_operator = 10 AND COUNT(1) <= SUM(vps.finish_flag)) THEN 'finish'
	        WHEN (s.step_class = 20 AND vlse.step_operator = 20 AND  0 < SUM(vps.finish_flag)) THEN 'finish'
	        WHEN (s.step_class = 30 AND 0 < SUM(vps.active_flag)) THEN 'finish'
	        WHEN (s.step_class = 30 AND 0 < SUM(vps.finish_flag)) THEN 'finish'
	        ELSE 'none'
        END) as step_status
      FROM steps s
      INNER JOIN view_latest_step_events vlse ON s.id = vlse.step_id
      INNER JOIN view_person_statuses vps ON vlse.id = vps.step_event_id
      GROUP BY s.id, s.flow_id, s.step_class, vlse.id, vlse.step_name, vlse.step_order, vlse.step_operator
    SQL
  end
end
