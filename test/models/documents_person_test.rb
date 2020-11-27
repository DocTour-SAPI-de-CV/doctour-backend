# frozen_string_literal: true

require 'test_helper'

class DocumentsPersonTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = documents_people(:dgp_maria)
    assert @objective.valid?
  end
end
