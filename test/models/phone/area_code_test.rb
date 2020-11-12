# frozen_string_literal: true

require 'test_helper'

class PhoneAreaCodeTest < ActiveSupport::TestCase
  setup do
    @phone = phones(:maria_phone)
  end

  test 'must not be nil' do
    assert_nil @phone.area_code = nil
    assert_not @phone.area_code.present?
    assert_not @phone.valid?
    assert_includes @phone.errors[:area_code], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @phone.area_code = ''
    assert_not @phone.area_code.present?
    assert_not @phone.valid?
    assert_includes @phone.errors[:area_code], "can't be blank"
  end

  test 'must only have digits' do
    @phone.area_code = 'aa'
    assert_not @phone.valid?
    assert_includes @phone.errors[:area_code], 'is not a number'
  end

  test 'may have only one digit' do
    @phone.area_code = '1'
    assert @phone.valid?
  end

  test 'may have two digits' do
    @phone.area_code = '55'
    assert @phone.valid?
  end

  test 'must not have more than four digits' do
    @phone.area_code = '55555'
    assert_not @phone.valid?
  end
end
