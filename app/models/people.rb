class People < ApplicationRecord
    validates :first_name,
        format: {with: /[a-zA-Z]/},
        length: { minimum: 2 },
        presence: {message: "is required"}
    validates :last_name,
        format: {with: /[a-zA-Z]/},
        length: { minimum: 2 },
        presence: {message: "is required or invalid"}
    validates :birthdate,
        presence: {message: "is required or invalid"}
    validates :gender,
    inclusion: {
        in: %w[
            female,
            male
        ],
        message: 'not a valid gender'
    },
    length: { minimum: 2 },
    presence: {message: "is required or invalid"}

end
