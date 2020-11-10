# frozen_string_literal: true

require 'test_helper'

class ObjectiveTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = objectives(:sarampo)
    assert @objective.valid?
  end
end
