# frozen_string_literal: true

require 'test_helper'

class PeoplePhoneTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = people_phones(:person_maria_phone)
    assert @objective.valid?
  end
end
