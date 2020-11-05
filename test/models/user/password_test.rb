# frozen_string_literal: true

require 'test_helper'

class UserPasswordTest < ActiveSupport::TestCase
  def setup
    @user = users(:felipe_abacate)
  end

  test 'must not be nil' do
    assert_nil @user.encrypted_password = nil
    assert_not @user.valid?
    assert_includes @user.errors[:encrypted_password], "can't be blank"
  end

  test 'password must have more than 8 chars' do
    @user.encrypted_password = 'a' * 7
    assert_not @user.valid?
    assert @user
      .errors[:encrypted_password]
      .include? 'is too short (minimum is 8 characters)'

    @user.encrypted_password = 'a' * 8
    assert @user.valid?
  end

  test 'password must have less than 72 chars' do
    @user.encrypted_password = 'a' * 73
    assert_not @user.valid?
    assert @user
      .errors[:encrypted_password]
      .include? 'is too long (maximum is 72 characters)'

    @user.encrypted_password = 'a' * 72
    assert @user.valid?
  end
end
