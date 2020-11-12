# frozen_string_literal: true

require 'test_helper'

class DoctorPhotoTest < ActiveSupport::TestCase
  setup do
    @objective = doctors(:doctor_maria)
  end

  test 'must not be nil' do
    assert_nil @objective.photo = nil
    assert_not @objective.photo.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:photo], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.photo = ''
    assert @objective.photo.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:photo], "can't be blank"
  end
end
