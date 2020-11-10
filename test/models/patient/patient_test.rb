# frozen_string_literal: true

require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = patients(:patient_felipe)
    assert @objective.valid?
  end
end
