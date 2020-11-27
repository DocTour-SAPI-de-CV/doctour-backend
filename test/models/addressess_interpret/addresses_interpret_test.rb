# frozen_string_literal: true

require 'test_helper'

class AddressesInterpretTest < ActiveSupport::TestCase
  test 'the truth' do
    @objective = addresses_interprets(:address_andre)
    assert @objective.valid?
  end
end
