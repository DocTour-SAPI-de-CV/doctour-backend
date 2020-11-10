# frozen_string_literal: true

require 'test_helper'

class SpecializationNameTest < ActiveSupport::TestCase
  setup do
    @objective = specializations(:pediatria)
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
    @objective.name = 'diabetes'
    assert @objective.name.present?
    assert @objective.valid?
  end

  test 'must be unique case insensitive' do
    another_objective = specializations(:cardiologia)
    @objective.name = another_objective.name.upcase

    assert_not_equal @objective.name, another_objective.name
    assert_equal @objective.name.downcase, another_objective.name.downcase

    assert_not @objective.valid?
    assert_includes @objective.errors[:name], 'has already been taken'
  end
end
