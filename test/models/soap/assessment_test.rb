# frozen_string_literal: true

require 'test_helper'

class SoapAssessmentTest < ActiveSupport::TestCase
  setup do
    @objective = soaps(:soap_1)
  end

  test 'must not be nil' do
    assert_nil @objective.assessment = nil
    assert_not @objective.assessment.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:assessment], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.assessment = ''
    assert @objective.assessment.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:assessment], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.assessment = 'acho que e covid'
    assert @objective.assessment.present?
    assert @objective.valid?
  end
end
