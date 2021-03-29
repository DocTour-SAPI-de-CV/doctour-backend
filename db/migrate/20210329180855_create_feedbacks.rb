class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :title
      t.integer :message_type
      t.text :message

      t.timestamps
    end
  end
end
