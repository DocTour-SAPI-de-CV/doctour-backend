# frozen_string_literal: true

class DiagnosticFinder < ApplicationFinder
  def find(params)
    if params.key?(:name)
      @diagnostic = Diagnostic.find_by(name: params[:name].downcase!)
    elsif params.key?(:code)
      @diagnostic = Diagnostic.find_by(code: params[:code])
    end

    info
  end

  def info
    if @diagnostic
      {
        code: @diagnostic.code,
        name: @diagnostic.name
      }
    else
      {
        error: 'Must filter by code or name!'
      }
    end
  end
end
