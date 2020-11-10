# frozen_string_literal: true

class ObjectiveController < ApplicationController
  include ErrorSerializer

  def show
    render(json: { objective: Objective.all })
  end

  def index
    render(json: { objective: Objective.find(params[:id]) })
  end

  def create
    objective = Objective.new(objective_params)
    render(json: { objective: objective }) if objective.save

    render(json: { error: objective.errors }) unless objective.save
  end

  def delete
    @objective = Objective.find(params[:id])
    @objective.destroy!
    render(json: { "objective_id deleted": params[:id] })
  end

  def update
    objective = Objective.find(params[:id])
    render(json: { objective: objective }) if objective.update(objective_params)

    render(json: { error: objective.errors }) unless objective.update(objective_params)
  end

  private

  def objective_params
    params.require(:objective).permit(:name)
  end
end
