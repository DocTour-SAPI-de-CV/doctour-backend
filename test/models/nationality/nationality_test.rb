# frozen_string_literal: true

require 'test_helper'

class NationalityTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = nationalities(:brazilian)
    assert @objective.valid?
  end
end
