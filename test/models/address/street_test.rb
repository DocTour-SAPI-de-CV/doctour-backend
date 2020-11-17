# frozen_string_literal: true

require 'test_helper'

class AddressStreetTest < ActiveSupport::TestCase
  setup do
    @objective = addresses(:maria_address)
  end

  test 'must not be nil' do
    assert_nil @objective.street = nil
    assert_not @objective.street.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:street], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.street = ''
    assert @objective.street.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:street], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.street = 'Av. Brasil'
    assert @objective.street.present?
    assert @objective.valid?
  end
end
