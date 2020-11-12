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
    render(json: { people: people }) if people.save

    render(json: { error: people.errors }) unless people.save
  end

  def delete
    @people = People.find(params[:id])
    @people.destroy!

    render(json: { "people_id deleted": params[:id] })
  end

  def update
    people = People.find(params[:id])
    render(json: { people: people }) if people.update(people_params)

    render(json: { error: people.errors }) unless people.update(people_params)
  end

  private

  def people_params
    params.require(:person).permit(:first_name,
                                   :last_name,
                                   :birthdate,
                                   :gender,
                                   :account_id)
  end
end
