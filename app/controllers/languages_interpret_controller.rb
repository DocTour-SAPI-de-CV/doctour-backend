# frozen_string_literal: true

# rubocop:disable Style/GuardClause

class LanguagesInterpretController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { languages_interpret: LanguagesInterpret.all })
  end

  def index
    render(json: { languages_interpret: LanguagesInterpret.find(params[:id]) })
  end

  def create
    languages_interpret = LanguagesInterpret.new(languages_interpret_params)
    render(json: { languages_interpret: languages_interpret }) if languages_interpret.save

    render(json: { error: languages_interpret.errors }) unless languages_interpret.save
  end

  def delete
    @languages_interpret = LanguagesInterpret.find(params[:id])
    @languages_interpret.destroy!
    render(json: { "languages_interpret_id deleted": params[:id] })
  end

  def update
    languages_interpret = LanguagesInterpret.find(params[:id])
    if languages_interpret.update(languages_interpret_params)
      render(json: { languages_interpret: languages_interpret })
    end

    unless languages_interpret.update(languages_interpret_params)
      render(json: { error: languages_interpret.errors })
    end
  end

  private

  def languages_interpret_params
    params.require(:languages_interpret).permit(:language_id, :interpret_id)
  end
end
# rubocop:enable Style/GuardClause
