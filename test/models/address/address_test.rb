# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = addresses(:maria_address)
    assert @objective.valid?
  end
end
