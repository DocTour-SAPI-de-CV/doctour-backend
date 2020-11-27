# frozen_string_literal: true

require 'test_helper'

class InterpretTest < ActiveSupport::TestCase
  test 'the truth' do
    @objective = interprets(:andre_tradutor)
    assert @objective.valid?
  end
end
