class InterpreterAvailability < ApplicationRecord
    belongs_to :interpret
    validates :availability_in, presence: true
    validates :availability_out, presence: true
end
