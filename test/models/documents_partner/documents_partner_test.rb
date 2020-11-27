# frozen_string_literal: true

require 'test_helper'

class DocumentsPartnerTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @objective = documents_partners(:rfc_hotel_cancun)
    assert @objective.valid?
  end
end
