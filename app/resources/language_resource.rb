class LanguageResource < JSONAPI::Resource
  attributes :name, :created_at
  has_many :languages_interprets

end
