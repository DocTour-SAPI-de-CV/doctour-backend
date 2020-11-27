# frozen_string_literal: true

require 'test_helper'

class PartnerNameTest < ActiveSupport::TestCase
  setup do
    @objective = partners(:hotel_cancun)
  end

  test 'must not be nil' do
    assert_nil @objective.name = nil
    assert_not @objective.name.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:name], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.name = ''
    assert @objective.name.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:name], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.name = 'Hotel das Nuvens'
    assert @objective.name.present?
    assert @objective.valid?
  end
end
