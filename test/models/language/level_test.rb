# frozen_string_literal: true

require 'test_helper'

class LanguageLevelTest < ActiveSupport::TestCase
  setup do
    @language = languages(:portuguese)
  end

  test 'must not be nil' do
    assert_nil @language.level = nil
    assert_not @language.level.present?
    assert_not @language.valid?
    assert_includes @language.errors[:level], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @language.level = ''
    assert @language.level.blank?
    assert_not @language.valid?
    assert_includes @language.errors[:level], "can't be blank"
  end

  test 'must be valid when present' do
    @language.level = 'fluent'
    assert @language.level.present?
    assert @language.valid?
  end
end
