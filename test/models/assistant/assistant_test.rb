# frozen_string_literal: true

require 'test_helper'

class AssistantTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = assistants(:assistant_chris)
    assert @objective.valid?
  end
end
