# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_06_134053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "category", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id", unique: true
  end

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "street", null: false
    t.integer "street_number", null: false
    t.string "zipcode", null: false
    t.string "country", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "addresses_interprets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "address_id", null: false
    t.uuid "interpret_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_addresses_interprets_on_address_id"
    t.index ["interpret_id"], name: "index_addresses_interprets_on_interpret_id"
  end

  create_table "addresses_partners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id", null: false
    t.uuid "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_addresses_partners_on_address_id"
    t.index ["partner_id"], name: "index_addresses_partners_on_partner_id"
  end

  create_table "addresses_people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.uuid "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_addresses_people_on_address_id"
    t.index ["person_id"], name: "index_addresses_people_on_person_id"
  end

  create_table "assistants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.integer "status", null: false
    t.string "photo", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_assistants_on_person_id"
  end

  create_table "attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "file", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "attachments_people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "attachment_id", null: false
    t.uuid "person_patient_id", null: false
    t.uuid "person_doctor_id", null: false
    t.string "attachment_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachment_id"], name: "index_attachments_people_on_attachment_id"
    t.index ["person_doctor_id"], name: "index_attachments_people_on_person_doctor_id"
    t.index ["person_patient_id"], name: "index_attachments_people_on_person_patient_id"
  end

  create_table "diagnostics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_diagnostics_on_code", unique: true
  end

  create_table "diagnostics_soaps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "soap_id", null: false
    t.uuid "diagnostic_id", null: false
    t.boolean "primary"
    t.text "observation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["diagnostic_id"], name: "index_diagnostics_soaps_on_diagnostic_id"
    t.index ["soap_id"], name: "index_diagnostics_soaps_on_soap_id"
  end

  create_table "doctors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.string "photo", null: false
    t.text "about", null: false
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_doctors_on_person_id", unique: true
  end

  create_table "doctors_specializations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "doctor_id", null: false
    t.uuid "specialization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_doctors_specializations_on_doctor_id"
    t.index ["specialization_id"], name: "index_doctors_specializations_on_specialization_id"
  end

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "document_type", null: false
    t.string "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_type", "number"], name: "index_documents_on_document_type_and_number", unique: true
  end

  create_table "documents_partners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id", null: false
    t.uuid "document_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id", "partner_id"], name: "index_documents_partners_on_document_id_and_partner_id", unique: true
    t.index ["document_id"], name: "index_documents_partners_on_document_id"
    t.index ["partner_id"], name: "index_documents_partners_on_partner_id"
  end

  create_table "documents_people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "document_id", null: false
    t.uuid "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["document_id", "person_id"], name: "index_documents_people_on_document_id_and_person_id", unique: true
    t.index ["document_id"], name: "index_documents_people_on_document_id"
    t.index ["person_id"], name: "index_documents_people_on_person_id"
  end

  create_table "interprets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "languages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "languages_interprets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "language_id", null: false
    t.uuid "interpret_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interpret_id"], name: "index_languages_interprets_on_interpret_id"
    t.index ["language_id"], name: "index_languages_interprets_on_language_id"
  end

  create_table "languages_people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "language_id", null: false
    t.uuid "person_id", null: false
    t.boolean "native", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_languages_people_on_language_id"
    t.index ["person_id"], name: "index_languages_people_on_person_id"
  end

  create_table "nationalities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_nationalities_on_name", unique: true
  end

  create_table "objectives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_objectives_on_name", unique: true
  end

  create_table "objectives_soaps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "objective_id", null: false
    t.uuid "soap_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["objective_id"], name: "index_objectives_soaps_on_objective_id"
    t.index ["soap_id", "objective_id"], name: "index_soap_objectives", unique: true
    t.index ["soap_id"], name: "index_objectives_soaps_on_soap_id"
  end

  create_table "partners", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "responsible_name", null: false
    t.text "observation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partners_phones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "partner_id", null: false
    t.uuid "phone_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["partner_id"], name: "index_partners_phones_on_partner_id"
    t.index ["phone_id"], name: "index_partners_phones_on_phone_id"
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "privacy_polity", null: false
    t.boolean "terms_use", null: false
    t.cidr "client_ip", null: false
    t.uuid "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_patients_on_person_id", unique: true
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.date "birthdate", null: false
    t.string "gender", null: false
    t.uuid "account_id", null: false
    t.uuid "nationality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_people_on_account_id", unique: true
    t.index ["nationality_id"], name: "index_people_on_nationality_id"
  end

  create_table "people_phones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.uuid "phone_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_people_phones_on_person_id"
    t.index ["phone_id"], name: "index_people_phones_on_phone_id"
  end

  create_table "phones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "country_code", null: false
    t.string "area_code", null: false
    t.string "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "phones_interprets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "interpret_id", null: false
    t.uuid "phone_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["interpret_id"], name: "index_phones_interprets_on_interpret_id"
    t.index ["phone_id"], name: "index_phones_interprets_on_phone_id"
  end

  create_table "screenings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "performed_at", null: false
    t.boolean "return", null: false
    t.uuid "doctor_id", null: false
    t.uuid "patient_id", null: false
    t.float "temperature"
    t.integer "heart_rate"
    t.string "blood_pressure"
    t.float "weight", null: false
    t.integer "height", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_screenings_on_doctor_id"
    t.index ["patient_id"], name: "index_screenings_on_patient_id"
  end

  create_table "services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.float "price", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_services_on_name", unique: true
  end

  create_table "soaps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "subjective"
    t.text "objective"
    t.text "assessment", null: false
    t.text "plan", null: false
    t.text "observation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "screening_id", null: false
    t.index ["screening_id"], name: "index_soaps_on_screening_id"
  end

  create_table "specializations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_specializations_on_name", unique: true
  end

  create_table "subjectives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_subjectives_on_name", unique: true
  end

  create_table "subjectives_soaps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "subjective_id", null: false
    t.uuid "soap_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soap_id", "subjective_id"], name: "index_soap_subjectives", unique: true
    t.index ["soap_id"], name: "index_subjectives_soaps_on_soap_id"
    t.index ["subjective_id"], name: "index_subjectives_soaps_on_subjective_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "addresses_interprets", "addresses", on_update: :cascade, on_delete: :cascade
  add_foreign_key "addresses_interprets", "interprets", on_update: :cascade, on_delete: :cascade
  add_foreign_key "addresses_partners", "addresses", on_update: :cascade, on_delete: :cascade
  add_foreign_key "addresses_partners", "partners", on_update: :cascade, on_delete: :cascade
  add_foreign_key "addresses_people", "addresses", on_update: :cascade, on_delete: :cascade
  add_foreign_key "addresses_people", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "assistants", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "attachments_people", "attachments", on_update: :cascade, on_delete: :cascade
  add_foreign_key "attachments_people", "people", column: "person_doctor_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "attachments_people", "people", column: "person_patient_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "diagnostics_soaps", "diagnostics", on_update: :cascade, on_delete: :cascade
  add_foreign_key "diagnostics_soaps", "soaps", on_update: :cascade, on_delete: :cascade
  add_foreign_key "doctors", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "doctors_specializations", "doctors", on_update: :cascade, on_delete: :cascade
  add_foreign_key "doctors_specializations", "specializations", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents_partners", "documents", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents_partners", "partners", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents_people", "documents", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documents_people", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "languages_interprets", "interprets", on_update: :cascade, on_delete: :cascade
  add_foreign_key "languages_interprets", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "languages_people", "languages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "languages_people", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "objectives_soaps", "objectives", on_update: :cascade, on_delete: :cascade
  add_foreign_key "objectives_soaps", "soaps", on_update: :cascade, on_delete: :cascade
  add_foreign_key "partners_phones", "partners", on_update: :cascade, on_delete: :cascade
  add_foreign_key "partners_phones", "phones", on_update: :cascade, on_delete: :cascade
  add_foreign_key "patients", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "people", "accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "people", "nationalities", on_update: :cascade, on_delete: :cascade
  add_foreign_key "people_phones", "people", on_update: :cascade, on_delete: :cascade
  add_foreign_key "people_phones", "phones", on_update: :cascade, on_delete: :cascade
  add_foreign_key "phones_interprets", "interprets", on_update: :cascade, on_delete: :cascade
  add_foreign_key "phones_interprets", "phones", on_update: :cascade, on_delete: :cascade
  add_foreign_key "screenings", "doctors", on_update: :cascade, on_delete: :cascade
  add_foreign_key "screenings", "patients", on_update: :cascade, on_delete: :cascade
  add_foreign_key "soaps", "screenings", on_update: :cascade, on_delete: :cascade
  add_foreign_key "subjectives_soaps", "soaps", on_update: :cascade, on_delete: :cascade
  add_foreign_key "subjectives_soaps", "subjectives", on_update: :cascade, on_delete: :cascade
end
