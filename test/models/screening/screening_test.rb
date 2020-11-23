# frozen_string_literal: true

require 'test_helper'

class ScreeningTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = screenings(:screening_felipe)
    assert @objective.valid?
  end
end
