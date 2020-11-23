# frozen_string_literal: true

require 'test_helper'

class DiagnosticsSoapTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = diagnostics_soap(:diagnostics_soap_one)
    assert @objective.valid?
  end
end
