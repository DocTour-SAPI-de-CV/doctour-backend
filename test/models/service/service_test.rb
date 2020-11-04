# frozen_string_literal: true

require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = services(:telehealth)
    assert @objective.valid?
  end
end
