# frozen_string_literal: true

require 'test_helper'

class ServiceDescriptionTest < ActiveSupport::TestCase
  setup do
    @objective = services(:telehealth)
  end

  test 'may be nil' do
    assert_nil @objective.description = nil
    assert_not @objective.description.present?
    assert @objective.valid?
  end

  test 'may be blank' do
    assert_empty @objective.description = ''
    assert @objective.description.blank?
    assert @objective.valid?
  end

  test 'must be valid when present' do
    @objective.description = 'Test description field'
    assert @objective.description.present?
    assert @objective.valid?
  end
end
