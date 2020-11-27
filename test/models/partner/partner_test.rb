# frozen_string_literal: true

require 'test_helper'

class PartnerTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = partners(:hotel_cancun)
    assert @objective.valid?
  end
end
