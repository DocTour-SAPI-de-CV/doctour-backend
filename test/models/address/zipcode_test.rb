# frozen_string_literal: true

require 'test_helper'

class AddressZipcodeTest < ActiveSupport::TestCase
  setup do
    @objective = addresses(:maria_address)
  end

  test 'must not be nil' do
    assert_nil @objective.zipcode = nil
    assert_not @objective.zipcode.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:zipcode], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.zipcode = ''
    assert @objective.zipcode.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:zipcode], "can't be blank"
  end

  test 'must be valid when present only numbers' do
    @objective.zipcode = '96050000'
    assert @objective.zipcode.present?
    assert @objective.valid?
  end

  test 'must be valid when present digits and numbers' do
    @objective.zipcode = 'AZ056X'
    assert @objective.zipcode.present?
    assert @objective.valid?
  end
end
