# frozen_string_literal: true

require 'test_helper'

class PhonesInterpretTest < ActiveSupport::TestCase
  test 'the truth' do
    @objective = phones_interprets(:phones_andre)
    assert @objective.valid?
  end
end
