# frozen_string_literal: true

require 'test_helper'

class PeopleFirstNameTest < ActiveSupport::TestCase
  setup do
    @objective = peoples(:person_felipe)
  end

  test 'must be valid when present' do
    @objective.first_name = 'Felipe'
    assert @objective.first_name.present?
    assert @objective.valid?
  end
end
