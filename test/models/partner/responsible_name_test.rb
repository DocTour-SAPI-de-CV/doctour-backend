# frozen_string_literal: true

require 'test_helper'

class PartnerResponsibleNameTest < ActiveSupport::TestCase
  setup do
    @objective = partners(:hotel_cancun)
  end

  test 'must not be nil' do
    assert_nil @objective.responsible_name = nil
    assert_not @objective.responsible_name.present?
    assert_not @objective.valid?
    assert_includes @objective.errors[:responsible_name], "can't be blank"
  end

  test 'must not be blank' do
    assert_empty @objective.responsible_name = ''
    assert @objective.responsible_name.blank?
    assert_not @objective.valid?
    assert_includes @objective.errors[:responsible_name], "can't be blank"
  end

  test 'must be valid when present' do
    @objective.responsible_name = 'Hotel das Nuvens'
    assert @objective.responsible_name.present?
    assert @objective.valid?
  end
end
