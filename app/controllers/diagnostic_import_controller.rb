# frozen_string_literal: true

class DiagnosticImportController < DiagnosticController
  def index
    result = DiagnosticImporter.file(params)
    Diagnostic.insert_all(result)

    render(json: { diagnostic: 'Dignostics are imported!' })
  end
end
