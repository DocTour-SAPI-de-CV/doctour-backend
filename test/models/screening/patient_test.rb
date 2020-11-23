# frozen_string_literal: true

require 'test_helper'

class ScreeningPatientTest < ActiveSupport::TestCase
  setup do
    @screening = screenings(:screening_felipe)
  end

  test 'must be present' do
    assert_nil @screening.patient_id = nil
    assert_not @screening.valid?
    assert_includes @screening.errors[:patient],
                    "can't be blank"
  end

  test 'must exist' do
    @screening.patient_id = 'not a valid id'
    assert_not @screening.valid?
    assert_includes @screening.errors[:patient],
                    'must exist'
  end
end
