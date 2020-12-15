# frozen_string_literal: true

class NationalityController < ApplicationController
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { nationalities: Nationality.all })
  end

  def index
    render(json: { nationality: Nationality.find(params[:id]) })
  end

  def create
    nationality = Nationality.new(nationality_params)
    render(json: { nationality: nationality }) if nationality.save

    render(json: { error: nationality.errors }) unless nationality.save
  end

  def delete
    @nationality = Nationality.find(params[:id])
    @nationality.destroy!
    render(json: { "nationality_id deleted": params[:id] })
  end

  def update
    nationality = Nationality.find(params[:id])
    render(json: { nationality: nationality }) if nationality.update(nationality_params)

    render(json: { error: nationality.errors }) unless nationality.update(nationality_params)
  end

  private

  def nationality_params
    params.require(:nationality).permit(:name)
  end
end
