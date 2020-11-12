# frozen_string_literal: true

require 'test_helper'

class DoctorsSpecializationTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = doctors_specializations(:maria_cardiologista)
    assert @objective.valid?
  end
end
