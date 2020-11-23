# frozen_string_literal: true

require 'test_helper'

class ScreeningWeightTest < ActiveSupport::TestCase
  setup do
    @screening = screenings(:screening_felipe)
  end

  test 'must not be nil' do
    assert_nil @screening.weight = nil
    assert_not @screening.weight.present?
    assert_not @screening.valid?
    assert_includes @screening.errors[:weight], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @screening.weight = ''
    assert @screening.weight.blank?
    assert_not @screening.valid?
    assert_includes @screening.errors[:weight], "can't be blank"
  end

  test 'must be valid when present' do
    @screening.weight = 60.0
    assert @screening.weight.present?
    assert @screening.valid?
  end
end
