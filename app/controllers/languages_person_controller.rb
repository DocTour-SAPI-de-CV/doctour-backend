# frozen_string_literal: true

# rubocop:disable Style/GuardClause
class LanguagesPersonController < ApplicationController
    include ErrorSerializer
  
    # rescue_from ActionController::ParameterMissing, with: :missing_params
  
    def show
      render(json: { languages_person: LanguagesPerson.all })
    end
  
    def index
      render(json: { languages_person: LanguagesPerson.find(params[:id]) })
    end
  
    def create
      languages_person = LanguagesPerson.new(languages_person_params)
      render(json: { languages_person: languages_person }) if languages_person.save
  
      render(json: { error: languages_person.errors }) unless languages_person.save
    end
  
    def delete
      @languages_person = LanguagesPerson.find(params[:id])
      @languages_person.destroy!
      render(json: { "languages_person_id deleted": params[:id] })
    end
  
    def update
      languages_person = LanguagesPerson.find(params[:id])
      if languages_person.update(languages_person_params)
        render(json: { languages_person: languages_person })
      end
  
      unless languages_person.update(languages_person_params)
        render(json: { error: languages_person.errors })
      end
    end
  
    private
  
    def languages_person_params
      params.require(:languages_person).permit(:person_id, :language_id)
    end
end
  # rubocop:enable Style/GuardClause
  