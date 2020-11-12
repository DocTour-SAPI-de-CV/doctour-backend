# frozen_string_literal: true

require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = doctors(:doctor_maria)
    assert @objective.valid?
  end
end
