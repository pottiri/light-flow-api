# フローの検索処理
class FlowSearchService
  def initialize; end

  # 検索
  def search(params)
    rtn = {}
    rtn[:message] = ''
    query = ViewFlowStatus.where('1 = 1')
    unless params[:creator_key].blank?
      query = query.where(creator_key: params[:creator_key])
    end
    unless params[:flow_status].blank?
      query = query.where(flow_status: params[:flow_status])
    end
    unless params[:step_order].blank?
      query = query.where(step_order: params[:step_order])
    end
    unless params[:person_key].blank? && params[:person_status].blank?
      flows = ViewFlowStatus.arel_table
      steps = Step.arel_table
      step_events = ViewLatestStepEvent.arel_table
      people = ViewPersonStatus.arel_table
      condition =
        steps.project(1)
             .join(step_events)
             .on(steps[:id].eq(step_events[:step_id]))
             .join(people)
             .on(step_events[:id].eq(people[:step_event_id]))
             .where(flows[:id].eq(steps[:flow_id]))
      unless params[:person_key].blank?
        condition = condition.where(people[:person_key].eq(params[:person_key]))
      end
      unless params[:person_status].blank?
        condition = condition.where(people[:person_status].eq(params[:person_status]))
      end
      query = query.where(condition.exists)
    end
    query = query.order('created_at ASC')
    rtn[:count] = query.count
    rtn[:list] = query.all if params[:count].blank?
    rtn
  end
end
