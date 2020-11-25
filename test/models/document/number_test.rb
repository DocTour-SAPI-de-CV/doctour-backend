# frozen_string_literal: true

require 'test_helper'

class DocumentNumberTest < ActiveSupport::TestCase
  setup do
    @document = documents(:felipe_abacate_passport)
  end

  test 'must not be nil' do
    assert_nil @document.number = nil
    assert_not @document.number.present?
    assert_not @document.valid?
    assert_includes @document.errors[:number], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @document.number = ''
    assert_not @document.number.present?
    assert_not @document.valid?
    assert_includes @document.errors[:number], "can't be blank"
  end

  test 'number must not repeat with the same type' do
    silva_passport = documents(:felipe_silva_passport)

    assert silva_passport.valid?
    silva_passport.number = @document.number

    assert_equal silva_passport.document_type, @document.document_type
    assert_equal silva_passport.number, @document.number

    assert_not silva_passport.valid?
    assert_includes silva_passport.errors[:number],
                    'has already been taken'
  end
end
