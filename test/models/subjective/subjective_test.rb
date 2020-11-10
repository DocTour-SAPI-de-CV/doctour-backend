# frozen_string_literal: true

require 'test_helper'

class SubjectiveTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = subjectives(:febre)
    assert @objective.valid?
  end
end
