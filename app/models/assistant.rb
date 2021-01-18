# frozen_string_literal: true

class Assistant < ApplicationRecord
  belongs_to :person, class_name: 'People'

  validates :person,
            uniqueness: true,
            presence: true

  validates :status,
            inclusion: {
              in: [0, 1, 2],
              message: 'is not valid status'
            },
            presence: { message: 'is required or invalid' }

  delegate :full_name, to: :person

  def as_json
    {
      id: id,
      photo: photo,
      status: status
    }
  end
end
