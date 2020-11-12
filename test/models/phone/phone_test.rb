# frozen_string_literal: true

require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = phones(:maria_phone)
    assert @objective.valid?
  end
end
