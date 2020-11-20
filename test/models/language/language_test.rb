# frozen_string_literal: true

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @language = languages(:portuguese)
    assert @language.valid?
  end
end
