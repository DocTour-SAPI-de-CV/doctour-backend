# frozen_string_literal: true

require 'test_helper'

class ScreeningDoctorTest < ActiveSupport::TestCase
  setup do
    @screening = screenings(:screening_felipe)
  end

  test 'must be present' do
    assert_nil @screening.doctor_id = nil
    assert_not @screening.valid?
    assert_includes @screening.errors[:doctor],
                    "can't be blank"
  end

  test 'must exist' do
    @screening.doctor_id = 'not a valid id'
    assert_not @screening.valid?
    assert_includes @screening.errors[:doctor],
                    'must exist'
  end
end
