# frozen_string_literal: true

require 'test_helper'

class PartnersPhoneTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = partners_phones(:hotel_cancun_phone)
    assert @objective.valid?
  end
end
