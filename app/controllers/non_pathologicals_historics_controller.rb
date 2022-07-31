class NonPathologicalsHistoricsController < ApplicationController
  include ErrorSerializer

  # rescue_from ActionController::ParameterMissing, with: :missing_params

  def show
    render(json: { pathologicals_non_historic: NonPathologicalsHistoric.all })
  end

  def index
    render(json: { pathologicals_non_historic: NonPathologicalsHistoric.find(params[:id]) })
  end

  def create
    pathological_non_historic = NonPathologicalsHistoric.new(pathologicals_non_historic_params)
    render(json: { pathologicals_non_historic: pathological_non_historic }) if pathological_non_historic.save

    render(json: { error: pathological_non_historic.errors }) unless pathological_non_historic.save
  end

  def delete
    @pathological_non_historic = NonPathologicalsHistoric.find(params[:id])
    @pathological_non_historic.destroy!
    render(json: { "pathological_historic_id deleted": params[:id] })
  end

  def update
    pathological_non_historic = NonPathologicalsHistoric.find(params[:id])
    render(json: { screening: pathological_non_historic }) if pathological_non_historic.update(pathologicals_non_historic_params)

    render(json: { error: pathological_non_historic.errors }) unless pathological_non_historic.update(pathologicals_non_historic_params)
  end

  private

  def pathologicals_non_historic_params
    params.require(:pathologicals_non_historic).permit(:patient_id,:drugs, :drugs_name,
                                                       :vaccines, :vaccines_name, :alcoholic,
                                                       :alcoholic_beverages, :tobacco, :tobacco_wallets,)
  end

end
