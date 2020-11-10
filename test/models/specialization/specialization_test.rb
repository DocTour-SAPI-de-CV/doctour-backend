# frozen_string_literal: true

require 'test_helper'

class SpecializationTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = specializations(:pediatria)
    assert @objective.valid?
  end
end
