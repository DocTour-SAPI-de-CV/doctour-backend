# frozen_string_literal: true

require 'test_helper'

class SoapTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = soaps(:soap_1)
    assert @objective.valid?
  end
end
