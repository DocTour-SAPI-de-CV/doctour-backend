# frozen_string_literal: true

require 'test_helper'

class DiagnosticTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = diagnostics(:febre)
    assert @objective.valid?
  end
end
