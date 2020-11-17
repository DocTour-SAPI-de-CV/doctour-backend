# frozen_string_literal: true

require 'test_helper'

class AddressesPersonTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = addresses_people(:person_maria_address)
    assert @objective.valid?
  end
end
