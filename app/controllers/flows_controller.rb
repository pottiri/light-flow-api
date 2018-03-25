# frozen_string_literal: true

class FlowsController < ApplicationController
  before_action :set_flow, only: %i[show update destroy]

  # GET /flows
  def index
    service = FlowSearchService.new
    result = service.search(params)
    result[:errors] = []
    render json: result
  end

  # GET /flows/1
  def show
    service = FlowGetShowService.new
    result = service.get(params[:id])
    result[:errors] = []
    render json: result
  end

  # POST /flows
  def create
    create_service = FlowCreateService.new
    ActiveRecord::Base.transaction do
      flow = create_service.create(params)
      get_service = FlowGetService.new
      result = get_service.get(flow.id)
      result[:errors] = []
      result[:validation_errors] = []
      render json: result
    end
    # rescue StandardError => e
    #   logger.error(e)
    #   result = {}
    #   result[:errors] = ['Create flow failed.']
    #   render json: result
  end

  # PATCH/PUT /flows/1
  def update
    if @flow.update(flow_params)
      render json: @flow
    else
      render json: @flow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /flows/1
  def destroy
    @flow.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_flow
    @flow = Flow.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def flow_params
    params.require(:flow).permit(:meta)
  end
end
