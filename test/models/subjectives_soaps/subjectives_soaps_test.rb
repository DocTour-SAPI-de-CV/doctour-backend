# frozen_string_literal: true

require 'test_helper'

class SubjectivesSoapTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = subjectives_soaps(:soap_1_febre)
    assert @objective.valid?
  end
end
