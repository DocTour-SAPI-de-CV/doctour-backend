class AddressResource < JSONAPI::Resource
  attributes :street, :street_number, :zipcode, :country, :city, :state, :created_at
 

end
