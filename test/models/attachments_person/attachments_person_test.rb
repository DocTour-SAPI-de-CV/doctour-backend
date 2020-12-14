# frozen_string_literal: true

require 'test_helper'

class AttachmentsPersonTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = attachments_people(:anexo_relation)
    assert !@objective.valid?
  end
end
