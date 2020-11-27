# frozen_string_literal: true

require 'test_helper'

class AddressesPartnerTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = addresses_partners(:hotel_cancun_address)
    assert @objective.valid?
  end
end
