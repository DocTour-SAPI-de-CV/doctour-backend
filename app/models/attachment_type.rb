# frozen_string_literal: true

class AttachmentType < ApplicationRecord
  has_one :attachments_person

  validates :name,
            format: { with: /[a-zA-Z]/ },
            length: { minimum: 2 },
            presence: { message: 'is required or invalid' }

  validates :create, presence: true

  validates :read, presence: true
end
