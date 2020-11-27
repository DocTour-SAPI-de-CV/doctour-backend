# frozen_string_literal: true

class AddScreeningToSoaps < ActiveRecord::Migration[6.0]
  def change
    add_reference :soaps,
                  :screening,
                  type: :uuid,
                  null: false,
                  foreign_key: {
                    on_update: :cascade,
                    on_delete: :cascade
                  }
  end
end
