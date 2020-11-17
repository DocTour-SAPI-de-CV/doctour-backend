# frozen_string_literal: true

require 'test_helper'

class AddressStateTest < ActiveSupport::TestCase
  setup do
    @objective = addresses(:maria_address)
  end

  test 'must not be nil' do
    assert_nil @objective.state = nil
    assert_not @objective.state.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:state], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.state = ''
    assert @objective.state.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:state], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.state = 'rio grande do norte'
    assert @objective.state.present?
    assert @objective.valid?
  end
end
