# rubocop:disable Style/GuardClause

class DiagnosticsSoapController < ApplicationController
    include ErrorSerializer
  
    # rescue_from ActionController::ParameterMissing, with: :missing_params
  
    def show
      render(json: { diagnostics_soap: DiagnosticsSoap.all })
    end
  
    def index
      render(json: { diagnostics_soap: DiagnosticsSoap.find(params[:id]) })
    end
  
    def create
      diagnostics_soap = DiagnosticsSoap.new(diagnostics_soap_params)
      render(json: { diagnostics_soap: diagnostics_soap }) if diagnostics_soap.save
  
      render(json: { error: diagnostics_soap.errors }) unless diagnostics_soap.save
    end
  
    def delete
      @diagnostics_soap = DiagnosticsSoap.find(params[:id])
      @diagnostics_soap.destroy!
      render(json: { "diagnostics_soap_id deleted": params[:id] })
    end
  
    def update
      diagnostics_soap = DiagnosticsSoap.find(params[:id])
      if diagnostics_soap.update(diagnostics_soap_params)
        render(json: { diagnostics_soap: diagnostics_soap })
      end
  
      unless diagnostics_soap.update(diagnostics_soap_params)
        render(json: { error: diagnostics_soap.errors })
      end
    end
  
    private
  
    def diagnostics_soap_params
      params.require(:diagnostics_soap).permit(:soap_id, :diagnostic_id, :primary, :observation)
    end
end
  # rubocop:enable Style/GuardClause