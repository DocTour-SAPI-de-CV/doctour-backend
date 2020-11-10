# frozen_string_literal: true

require 'test_helper'

class PeopleLastNameTest < ActiveSupport::TestCase
  setup do
    @objective = peoples(:person_felipe)
  end

  test 'must be valid when present' do
    @objective.last_name = 'Abacate'
    assert @objective.last_name.present?
    assert @objective.valid?
  end
end
