# frozen_string_literal: true

require 'test_helper'

class PhoneCountryCodeTest < ActiveSupport::TestCase
  setup do
    @phone = phones(:maria_phone)
  end

  test 'must not be nil' do
    assert_nil @phone.country_code = nil
    assert_not @phone.country_code.present?
    assert_not @phone.valid?
    assert_includes @phone.errors[:country_code], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @phone.country_code = ''
    assert_not @phone.country_code.present?
    assert_not @phone.valid?
    assert_includes @phone.errors[:country_code], "can't be blank"
  end

  test 'must only have digits' do
    @phone.country_code = 'aa'
    assert_not @phone.valid?
    assert_includes @phone.errors[:country_code], 'is not a number'
  end

  test 'may have only one number' do
    @phone.country_code = '1' # USA country code
    assert @phone.valid?
  end

  test 'may have two digits' do
    @phone.country_code = '55'
    assert @phone.valid?
  end

  test 'must not have more than four digits' do
    @phone.country_code = '55555'
    assert_not @phone.valid?
  end
end
