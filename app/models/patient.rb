# frozen_string_literal: true

class Patient < ApplicationRecord
  belongs_to :people

  validates :people, uniqueness: true

  validates :privacy_polity,
            inclusion: { in: [true],
                         message: 'You need to accept the Privacy Polity terms!' },
            presence: true

  validates :client_ip, presence: true

  validates :terms_use,
            inclusion: { in: [true],
                         message: 'You need to accept the terms of use!' },
            presence: true

  def created_at_mask
    created_at.strftime('%m/%d/%Y at %I:%M%p')
  end

  delegate :full_name, to: :people

  def email
    people.account.user.email
  end
end
