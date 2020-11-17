# frozen_string_literal: true

require 'test_helper'

class AddressStreetNumberTest < ActiveSupport::TestCase
  setup do
    @objective = addresses(:maria_address)
  end

  test 'must not be nil' do
    assert_nil @objective.street_number = nil
    assert_not @objective.street_number.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:street_number], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.street_number = ''
    assert @objective.street_number.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:street_number], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.street_number = 60
    assert @objective.street_number.present?
    assert @objective.valid?
  end
end
