# frozen_string_literal: true

require 'test_helper'

class ServicePriceTest < ActiveSupport::TestCase
  setup do
    @objective = services(:telehealth)
  end

  test 'must not be nil' do
    assert_nil @objective.price = nil
    assert_not @objective.price.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:price], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.price = ''
    assert @objective.price.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:price], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.price = 60.0
    assert @objective.price.present?
    assert @objective.valid?
  end
end
