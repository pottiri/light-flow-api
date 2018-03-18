class CreateViewFlowStatuses < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE VIEW view_flow_statuses AS
      SELECT
        f.*,
       (CASE
         WHEN (vss.step_class = 10 AND vss.step_status = 'active') THEN  'draft'
         WHEN (vss.step_class = 10 AND vss.step_status = 'rejected') THEN  'rejected'
         WHEN (vss.step_class = 90) THEN  'archive'
         ELSE 'active'
       END) as flow_status ,
        vss.step_num,
        vss.step_class,
        vss.step_status
      FROM flows f
      INNER JOIN view_step_statuses vss ON
            f.id = vss.flow_id
        AND (vss.step_status = 'rejected' OR vss.step_status = 'active')
    SQL
  end
end
