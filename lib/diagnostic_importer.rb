# frozen_string_literal: true

require 'creek'

# rubocop:disable Metrics/AbcSize
class DiagnosticImporter
  def self.file(params)
    @creek = Creek::Book.new(params[:file])
    @sheet = @creek.sheets[0]

    read_rows
    @diagnostic_hash
  end

  def self.read_rows
    i = 0
    @diagnostic_hash = []
    @sheet.rows.each do |row|
      unless row.values[2].nil? || row.values[2] == 'CATALOG_KEY'
        @diagnostic_hash << {
          code: row.values[2].to_s,
          name: row.values[3].to_s,
          created_at: Time.zone.now,
          updated_at: Time.zone.now
        }
      end
      Rails.logger.info i
      i += 1
    end
  end
end
# rubocop:enable Metrics/AbcSize
