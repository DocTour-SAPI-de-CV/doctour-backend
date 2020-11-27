# frozen_string_literal: true

require 'test_helper'

class DocumentDocumentTypeTest < ActiveSupport::TestCase
  setup do
    @document = documents(:felipe_abacate_passport)
  end

  test 'must not be nil' do
    assert_nil @document.document_type = nil
    assert_not @document.document_type.present?
    assert_not @document.valid?
    assert_includes @document.errors[:document_type], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @document.document_type = ''
    assert_not @document.document_type.present?
    assert_not @document.valid?
    assert_includes @document.errors[:document_type], "can't be blank"
  end

  test 'must be one of the defined document types' do
    Document::DOCUMENT_TYPES.each_value do |document_type|
      @document.document_type = document_type
      assert @document.valid?
    end
  end

  test 'must not be other' do
    @document.document_type = 'other'
    assert_not @document.valid?
    assert_includes @document.errors[:document_type],
                    'is not included in the list'
  end
end
