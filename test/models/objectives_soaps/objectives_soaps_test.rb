# frozen_string_literal: true

require 'test_helper'

class ObjectivesSoapTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = objectives_soaps(:soap_2_sarampo)
    assert @objective.valid?
  end
end
