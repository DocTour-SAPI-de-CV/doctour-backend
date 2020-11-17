# frozen_string_literal: true

require 'test_helper'

class AddressCityTest < ActiveSupport::TestCase
  setup do
    @objective = addresses(:maria_address)
  end

  test 'must not be nil' do
    assert_nil @objective.city = nil
    assert_not @objective.city.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:city], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.city = ''
    assert @objective.city.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:city], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.city = 'rio grande'
    assert @objective.city.present?
    assert @objective.valid?
  end
end
