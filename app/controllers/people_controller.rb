# frozen_string_literal: true

class PeopleController < ApplicationController
  include ErrorSerializer
  
  rescue_from ActionController::ParameterMissing, with: :missing_params
  
  def show
    render(json: { peoples: People.all })
  end
  
  def index
    render(json: { people: People.find(params[:id]) })
  end
  
	def create
		people = People.new(people_params)
		if people.save
			render(json: {people: people})
		else
			render(json: {error: people.errors})
		end
	end
  
  def delete
    @people = People.find(params[:id])
    @people.destroy!
    render(json: { "people_id deleted": params[:id] })
  end
  
	def update
		puts params[:person]
		people = People.find(params[:id])
		if people.update(people_params)
			render(json: {people: people})
		else
			render(json: {error: people.errors})
		end
	end
  
	private
	
	def people_params
    params.require(:person).permit(:first_name, :last_name, :birthdate, :gender)
	end
end
  