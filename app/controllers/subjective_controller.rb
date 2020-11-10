# frozen_string_literal: true

class SubjectiveController < ApplicationController
  include ErrorSerializer

  def show
    render(json: { subjective: Subjective.all })
  end

  def index
    render(json: { subjective: Subjective.find(params[:id]) })
  end

  def create
    subjective = Subjective.new(subjective_params)
    render(json: { subjective: subjective }) if subjective.save

    render(json: { error: subjective.errors }) unless subjective.save
  end

  def delete
    @subjective = Subjective.find(params[:id])
    @subjective.destroy!
    render(json: { "subjective_id deleted": params[:id] })
  end

  def update
    subjective = Subjective.find(params[:id])
    render(json: { subjective: subjective }) if subjective.update(subjective_params)

    render(json: { error: subjective.errors }) unless subjective.update(subjective_params)
  end

  private

  def subjective_params
    params.require(:subjective).permit(:name)
  end
end
