# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = accounts(:felipe_account)
    assert @objective.valid?
  end
end
