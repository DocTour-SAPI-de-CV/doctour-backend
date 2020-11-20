# frozen_string_literal: true

require 'test_helper'

class LanguagesPersonTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = languages_people(:language_person_maria)
    assert @objective.valid?
  end
end
