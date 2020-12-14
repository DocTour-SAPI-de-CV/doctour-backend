# frozen_string_literal: true

require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = attachments(:anexo_1)
    assert @objective.valid?
  end
end
