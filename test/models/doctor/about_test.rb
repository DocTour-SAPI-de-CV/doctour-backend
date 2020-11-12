# frozen_string_literal: true

require 'test_helper'

class DoctorAboutTest < ActiveSupport::TestCase
  setup do
    @objective = doctors(:doctor_maria)
  end

  test 'must not be nil' do
    assert_nil @objective.about = nil
    assert_not @objective.about.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:about], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.about = ''
    assert @objective.about.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:about], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.about = 'doutorado na área de saúde da família'
    assert @objective.about.present?
    assert @objective.valid?
  end
end
