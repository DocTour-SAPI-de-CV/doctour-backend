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


nationalities = [
"Afghanistan",
"Angola",
"Algeria",
"Argentina",
"Armenia",
"Australia",
"Austria",
"The Bahamas",
"Bangladesh",
"Belgium",
"Bolivia",
"Botswana",
"Brazil",
"Brunei",
"Bulgaria",
"Cape Verde",
"Cameroon",
"Cambodia",
"Canada",
"China",
"Chile",
"Colombia",
"Costa Rica",
"Croatia",
"Cuba",
"Czech Republic",
"Democratic Republic of Congo",
"Denmark",
"Dominican Republic",
"East Timor",
"Ecuador",
"Egypt",
"England",
"Finland",
"France",
"Germany",
"Greece",
"Haiti",
"Holland",
"Honduras",
"Hungary",
"Iceland",
"India	",
"Indonesia",
"Iran",
"Ireland",
"Israel",
"Italy",
"Ivory Coast",
"Jamaica",
"Japan",
"Kwait",
"Lebanon",
"Liberia",
"Lybia",
"Macedonia",
"Malaysia",
"Mexico",
"Morocco",
"Monaco",
"Mongolia",
"Nepal",
"NewZealand",
"Nigeria",
"North Korea",
"Norway",
"Palestine",
"Panama",
"Paraguay ",
"Peru",
"Poland",
"Portugal",
"Qatar",
"Romania",
"Russia",
"Scotland",
"Serbia",
"Singapore",
"Slovakia",
"Somalia",
"South Africa",
"South Korea",
"Spain",
"Sweden",
"Switzerland",
"Syria",
"Thailand",
"Tunisia",
"Turkey",
"Uruguay",
"United Arab Emirates",
"United Kingdom",
"United States of american",
"Venezuela",
"Vietnam",
"Wales",
"Zambia",
"Zimbabwe"
]

insert_nationalities = []

nationalities.each do |nationality|
  insert_nationalities << {
    name: nationality.downcase,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
end

Nationality.insert_all(insert_nationalities)

languages = [
  "spanish",
  "english",
  "chinese mandarim",
  "hindi",
  "french",
  "arabic",
  "bengali",
  "russian",
  "portuguese",
  "indonesian"
]

insert_languages = []

languages.each do |language|
  insert_languages << {
    name: language.downcase,
    created_at: DateTime.now,
    updated_at: DateTime.now
  }
end

Language.insert_all(insert_languages)