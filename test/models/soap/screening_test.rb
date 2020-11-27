# frozen_string_literal: true

require 'test_helper'

class SoapScreeningTest < ActiveSupport::TestCase
  setup do
    @doctor = soaps(:soap_1)
  end

  test 'must have an screening' do
    assert_nil @doctor.screening = nil
    assert_not @doctor.valid?
    assert_includes @doctor.errors[:screening], 'must exist'
  end
end
