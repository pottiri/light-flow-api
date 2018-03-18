class FlowsController < ApplicationController
  before_action :set_flow, only: [:show, :update, :destroy]

  # GET /flows
  def index
    service = FlowSearchService.new()
    render json: service.search(params)
  end

  # GET /flows/1
  def show
    render json: @flow
  end

  # POST /flows
  def create
    @flow = Flow.new(flow_params)

    if @flow.save
      render json: @flow, status: :created, location: @flow
    else
      render json: @flow.errors, status: :unprocessable_entity
    end
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
