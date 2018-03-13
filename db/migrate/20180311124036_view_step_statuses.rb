class ViewStepStatuses < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_step_statuses AS
      SELECT
        s.id,
        s.flow_id,
        s.step_num,
        s.step_class,
        vlsh.operator,
        (CASE
	        WHEN (s.step_class IN (10, 20, 90)
	              AND 0 < SUM(vps.running_flag)) THEN 'running'
	        WHEN (s.step_class IN (30)) THEN 'approved'
          WHEN (0 < SUM(vps.rejected_flag)) THEN 'none'
	        WHEN (vlsh.operator = 10 AND COUNT(1) <= SUM(vps.approved_flag)) THEN 'approved'
	        WHEN (vlsh.operator = 20 AND  0 < SUM(vps.approved_flag)) THEN 'approved'
	        ELSE 'none'
        END) as step_status
      FROM steps s
      INNER JOIN view_latest_step_histories vlsh ON s.id = vlsh.step_id
      INNER JOIN view_person_statuses vps ON vlsh.id = vps.step_history_id
      GROUP BY s.id, s.step_num, vlsh.operator
    SQL
  end
end
