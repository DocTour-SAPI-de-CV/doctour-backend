# frozen_string_literal: true

require 'test_helper'

class DiagnosticCodeTest < ActiveSupport::TestCase
  setup do
    @diagnostic = diagnostics(:febre)
  end

  test 'must not be nil' do
    assert_nil @diagnostic.code = nil
    assert_not @diagnostic.code.present?
    assert_not @diagnostic.valid?
    assert_includes @diagnostic.errors[:code], "can't be blank"
  end
end
