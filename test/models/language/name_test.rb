# frozen_string_literal: true

require 'test_helper'

class LanguageNameTest < ActiveSupport::TestCase
  setup do
    @language = languages(:portuguese)
  end

  test 'must not be nil' do
    assert_nil @language.name = nil
    assert_not @language.name.present?
    assert_not @language.valid?
    assert_includes @language.errors[:name], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @language.name = ''
    assert @language.name.blank?
    assert_not @language.valid?
    assert_includes @language.errors[:name], "can't be blank"
  end

  test 'must be valid when present' do
    @language.name = 'portuguese'
    assert @language.name.present?
    assert @language.valid?
  end

  test 'must be unique case insensitive' do
    another_language = languages(:english)
    @language.name = another_language.name.upcase

    assert_not_equal @language.name, another_language.name
    assert_equal @language.name.downcase, another_language.name.downcase

    assert_not @language.valid?
    assert_includes @language.errors[:name], 'has already been taken'
  end
end
