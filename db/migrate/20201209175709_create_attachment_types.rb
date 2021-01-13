class CreateAttachmentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :attachment_types, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name
      t.string :create, array: true, default: []
      t.string :read, array: true, default: []

      t.timestamps
    end
  end
end
