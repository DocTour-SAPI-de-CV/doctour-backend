class AddTableUserRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :user_requests, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string   :type
      t.string    :description
      t.string  :user_id
    end
  end
end
