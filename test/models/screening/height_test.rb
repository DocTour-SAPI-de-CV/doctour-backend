# frozen_string_literal: true

require 'test_helper'

class ScreeningHeightTest < ActiveSupport::TestCase
  setup do
    @screening = screenings(:screening_felipe)
  end

  test 'must not be nil' do
    assert_nil @screening.height = nil
    assert_not @screening.height.present?
    assert_not @screening.valid?
    assert_includes @screening.errors[:height], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @screening.height = ''
    assert @screening.height.blank?
    assert_not @screening.valid?
    assert_includes @screening.errors[:height], "can't be blank"
  end

  test 'must be valid when present' do
    @screening.height = 178
    assert @screening.height.present?
    assert @screening.valid?
  end
end
