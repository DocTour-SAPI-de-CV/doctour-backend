# frozen_string_literal: true

require 'test_helper'

class AccountCategoryTest < ActiveSupport::TestCase
  setup do
    @objective = accounts(:one)
  end

  test 'must not be nil' do
    assert_nil @objective.category = nil
    assert_not @objective.category.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:category], "can't be blank"
  end
end
