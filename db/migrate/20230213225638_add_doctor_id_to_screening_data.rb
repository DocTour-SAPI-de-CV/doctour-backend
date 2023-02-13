class AddDoctorIdToScreeningData < ActiveRecord::Migration[6.0]
  def change
    add_column :screening_data, :doctor_id, :string
  end
end
