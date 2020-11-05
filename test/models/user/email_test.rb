# frozen_string_literal: true

require 'test_helper'

class UserEmailTest < ActiveSupport::TestCase
  setup do
    @user = users(:felipe_abacate)
  end

  test 'must not be nil' do
    assert_nil @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @user.email = ''
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end
end
