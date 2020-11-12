# frozen_string_literal: true

require 'test_helper'

class DoctorPersonTest < ActiveSupport::TestCase
  setup do
    @doctor = doctors(:doctor_maria)
  end

  test 'must have an person' do
    assert_nil @doctor.person = nil
    assert_not @doctor.valid?
    assert_includes @doctor.errors[:person], 'must exist'
  end
end
