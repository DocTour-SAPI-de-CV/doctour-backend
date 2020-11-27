# frozen_string_literal: true

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    @document = documents(:felipe_abacate_passport)
    assert @document.valid?
  end
end
