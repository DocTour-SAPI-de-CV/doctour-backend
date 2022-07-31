class PathologicalsHistoricsController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { pathologicals_historic: PathologicalsHistoric.all })
  end

  def index
    render(json: { pathologicals_historic: PathologicalsHistoric.find(params[:id]) })
  end

  def create
    puts "create \n\n\n"
    puts pathological_historic_params
    puts params
    puts "fim \n\n\n\n"

    pathological_historic = PathologicalsHistoric.new(pathological_historic_params)
    render(json: { pathologicals_historic: pathological_historic }) if pathological_historic.save

    render(json: { error: pathological_historic.errors }) unless pathological_historic.save
  end

  def delete
    @pathological_historic = PathologicalsHistoric.find(params[:id])
    @pathological_historic.destroy!
    render(json: { "pathological_historic_id deleted": params[:id] })
  end

  def update
    pathological_historic = PathologicalsHistoric.find(params[:id])
    render(json: { screening: pathological_historic }) if pathological_historic.update(pathological_historic_params)

    render(json: { error: pathological_historic.errors }) unless pathological_historic.update(pathological_historic_params)
  end

  private

  def pathological_historic_params
    params.require(:pathologicals_historic).permit(:patient_id, :hypertension, :diabetes,
                                      :respiratory_disease, :respiratory_disease_text, :allergy,
                                      :allergy_text, :surgical_historic, :surgical_historic_text,
                                      :medicine, :medicine_text)
  end

end
