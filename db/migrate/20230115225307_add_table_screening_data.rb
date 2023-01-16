class AddTableScreeningData < ActiveRecord::Migration[6.0]
  def change
    create_table :screening_data, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :patient,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     on_update: :cascade,
                     on_delete: :cascade
                   }

      t.references :user,
                   type: :uuid,
                   null: false

      # Form 1
      t.string   :reason_consultation
      t.float    :temperature
      t.integer  :heart_rate
      t.string   :respiratory_frequency
      t.float    :weight
      t.integer  :height
      t.string   :bmi
      
      # Form 2
      t.string   :peea
      t.boolean  :neurological
      t.boolean  :genitourinario
      t.boolean  :respiratory
      t.boolean  :cardiologic
      t.boolean  :gastrointestinal
      t.boolean  :extremities
      t.string   :discoveries

      # Form 3
      t.boolean  :exam_request
      t.string   :exam_name
      t.string   :exam_result

      # Form 4
      t.boolean  :need_return
      t.string   :main_diagnosis
      t.string   :full_diagnosis
      t.text     :secondary_diagnoses
      t.string   :prognosis

      # Form 5
      # Medical treatment
      t.string   :medication
      t.string   :dosage
      t.string   :presentation
      t.string   :route_of_administration
      t.string   :frequency
      t.string   :duration
      t.string   :medicine

      # Exam
      t.string   :name
      t.string   :observation
      t.string   :exam_medication

      # General indications
      t.text   :general_indications


      t.timestamps
    end
  end
end
