# frozen_string_literal: true

require 'test_helper'

class PeopleTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = peoples(:person_felipe)
    assert @objective.valid?
  end
end
