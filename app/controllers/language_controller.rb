# frozen_string_literal: true

class LanguageController < ApplicationControllerJsonApi
  before_action :authenticate_user, except: :show

  include ErrorSerializer

  rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { languages: Language.all })
  end

  def index
    render(json: { language: Language.find(params[:id]) })
  end

  def create
    language = Language.new(language_params)
    render(json: { language: language }) if language.save

    render(json: { error: language.errors }) unless language.save
  end

  def delete
    @language = Language.find(params[:id])
    @language.destroy!
    render(json: { "language_id deleted": params[:id] })
  end

  def update
    language = Language.find(params[:id])
    render(json: { language: language }) if language.update(language_params)

    render(json: { error: language.errors }) unless language.update(language_params)
  end

  private

  def language_params
    params.require(:language).permit(:name)
  end
end
