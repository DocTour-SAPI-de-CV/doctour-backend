class CreateActionsToUser < ActiveRecord::Migration[6.0]
  def change
    create_table :actions_to_users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :description
      t.string :user_id

      t.timestamps
    end
  end
end
