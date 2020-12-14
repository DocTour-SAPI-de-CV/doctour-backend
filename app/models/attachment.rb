# frozen_string_literal: true

class Attachment < ApplicationRecord
  has_many :attachments_people, dependent: :destroy
  has_many :people, through: :attachments_people
end
