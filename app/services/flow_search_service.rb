# frozen_string_literal: true

# フローの検索処理
class FlowSearchService
  def initialize; end

  # 検索
  def search(params)
    rtn = {}
    query = ViewFlowStatus.where('1 = 1')
    if params[:flow_name].present?
      query = query.where('flow_name like ?', params[:flow_name])
    end
    if params[:creator_key].present?
      query = query.where(creator_key: params[:creator_key])
    end
    if params[:flow_status].present?
      query = query.where(flow_status: params[:flow_status])
    end
    if params[:step_order].present?
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
      if params[:person_key].present?
        condition = condition.where(people[:person_key].eq(params[:person_key]))
      end
      if params[:person_status].present?
        condition = condition.where(
          people[:person_status].eq(params[:person_status])
        )
      end
      query = query.where(condition.exists)
    end
    query = query.order('created_at ASC')
    rtn[:count] = query.count
    rtn[:list] = query.all if params[:count].blank?
    rtn
  end
end
