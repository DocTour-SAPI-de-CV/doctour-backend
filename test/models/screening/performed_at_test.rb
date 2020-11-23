# frozen_string_literal: true

require 'test_helper'

class ScreeningPerformedAt < ActiveSupport::TestCase
  setup do
    @screening = screenings(:screening_felipe)
  end

  test 'must be present' do
    assert_nil @screening.performed_at = nil
    assert_not @screening.performed_at.present?
    assert_not @screening.valid?
    assert_includes @screening.errors[:performed_at], "can't be blank"
  end

  test 'must be a date' do
    @screening.performed_at = 'not a date'
    assert_not @screening.valid?
    assert_includes @screening.errors[:performed_at], "can't be blank"
  end
end
