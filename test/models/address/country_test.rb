# frozen_string_literal: true

require 'test_helper'

class AddressCountryTest < ActiveSupport::TestCase
  setup do
    @objective = addresses(:maria_address)
  end

  test 'must not be nil' do
    assert_nil @objective.country = nil
    assert_not @objective.country.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:country], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.country = ''
    assert @objective.country.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:country], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.country = 'Brasil'
    assert @objective.country.present?
    assert @objective.valid?
  end
end
