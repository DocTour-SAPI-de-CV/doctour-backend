# frozen_string_literal: true

require 'test_helper'

class PhoneNumberTest < ActiveSupport::TestCase
  setup do
    @phone = phones(:maria_phone)
  end

  test 'must not be nil' do
    assert_nil @phone.number = nil
    assert_not @phone.number.present?
    assert_not @phone.valid?
    assert_includes @phone.errors[:number], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @phone.number = ''
    assert_not @phone.number.present?
    assert_not @phone.valid?
    assert_includes @phone.errors[:number], "can't be blank"
  end

  test 'is valid with 8 digits' do
    @phone.number = 99_999_999.to_s
    assert_equal 8, @phone.number.length
    assert @phone.valid?
  end

  test 'is valid with 9 digits' do
    @phone.number = 999_999_999.to_s
    assert_equal 9, @phone.number.length
    assert @phone.valid?
  end

  test 'must only have digits' do
    @phone.number = 'a' * 9
    assert_equal 9, @phone.number.length
    assert_not @phone.valid?
    assert_includes @phone.errors[:number], 'is not a number'
  end

  test 'minimum length is 5' do
    @phone.number = '9' * 4
    assert_equal 4, @phone.number.length
    assert_not @phone.valid?
    assert_includes @phone.errors[:number],
                    'is too short (minimum is 5 characters)'
  end

  test 'maximum length is 10' do
    @phone.number = '9' * 11
    assert_equal 11, @phone.number.length
    assert_not @phone.valid?
    assert_includes @phone.errors[:number],
                    'is too long (maximum is 10 characters)'
  end
end
