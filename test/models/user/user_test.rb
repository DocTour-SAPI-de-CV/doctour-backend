# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = users(:felipe_abacate)
    assert @objective.valid?
  end
end
