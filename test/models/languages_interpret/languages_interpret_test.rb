# frozen_string_literal: true

require 'test_helper'

class LanguagesInterpretTest < ActiveSupport::TestCase
  test 'the truth' do
    @objective = languages_interprets(:andre_inter_language)
    assert @objective.valid?
  end
end
