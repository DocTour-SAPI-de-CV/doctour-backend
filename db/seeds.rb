# frozen_string_literal: true
# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#   { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "rake"

Rake::Task.clear # necessary to avoid tasks being loaded several times in dev mode
Rails.application.load_tasks # providing your application name is 'sample'

Rake::Task["populate:setup"].invoke
Rake::Task["accounts:setup"].invoke

Faker::Config.locale = "pt-BR"

200.times do
  Feedback.create({
    name: Faker::Name.name,
    email: Faker::Internet.safe_email,
    phone: Faker::PhoneNumber.cell_phone,
    message_type: Faker::Number.between(from: 0, to: 1),
    message: Faker::Lorem.paragraph,
    title: Faker::Lorem.sentence,
  })
end
