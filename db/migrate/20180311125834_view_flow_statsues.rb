class ViewFlowStatsues < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_flow_statuses AS
      SELECT
        f.*,
       (CASE
         WHEN (vss.step_class = 10) THEN  'draft'
         WHEN (vss.step_class = 90) THEN  'archive'
         ELSE 'running'
       END) as status ,
        vss.step_num,
        vss.step_class,
        vss.step_status
      FROM flows f
      INNER JOIN view_step_statuses vss ON f.id = vss.flow_id AND vss.step_status = 'running'
    SQL
  end
end