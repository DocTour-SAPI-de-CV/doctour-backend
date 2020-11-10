# frozen_string_literal: true

require 'test_helper'

class SoapPlanTest < ActiveSupport::TestCase
  setup do
    @objective = soaps(:soap_1)
  end

  test 'must not be nil' do
    assert_nil @objective.plan = nil
    assert_not @objective.plan.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:plan], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.plan = ''
    assert @objective.plan.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:plan], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.plan = 'ficar quieto em casa'
    assert @objective.plan.present?
    assert @objective.valid?
  end
end
