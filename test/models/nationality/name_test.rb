# frozen_string_literal: true

require 'test_helper'

class NationalityNameTest < ActiveSupport::TestCase
  setup do
    @nationality = nationalities(:brazilian)
  end

  test 'must not be nil' do
    assert_nil @nationality.name = nil
    assert_not @nationality.name.present?
    assert_not @nationality.valid?
    assert_includes @nationality.errors[:name], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @nationality.name = ''
    assert @nationality.name.blank?
    assert_not @nationality.valid?
    assert_includes @nationality.errors[:name], "can't be blank"
  end

  test 'must be unique case insensitive' do
    another_nationality = nationalities(:american)
    @nationality.name = another_nationality.name.upcase

    assert_not_equal @nationality.name, another_nationality.name
    assert_equal @nationality.name.downcase, another_nationality.name.downcase

    assert_not @nationality.valid?
    assert_includes @nationality.errors[:name], 'has already been taken'
  end
end
