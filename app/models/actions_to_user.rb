# frozen_string_literal: true

class ActionsToUser < ApplicationRecord
  
  validates :description,
            presence: true

end
