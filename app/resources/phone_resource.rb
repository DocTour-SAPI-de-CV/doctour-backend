class PhoneResource < JSONAPI::Resource
  attributes :country_code, :area_code, :number, :created_at
 

end
