# frozen_string_literal: true

require 'test_helper'

class DiagnosticNameTest < ActiveSupport::TestCase
  setup do
    @diagnostic = diagnostics(:febre)
  end

  test 'must not be nil' do
    assert_nil @diagnostic.name = nil
    assert_not @diagnostic.name.present?
    assert_not @diagnostic.valid?
    assert_includes @diagnostic.errors[:name], "can't be blank"
  end
end
