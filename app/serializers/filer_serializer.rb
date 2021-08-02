class FilerSerializer
  include JSONAPI::Serializer
  
  set_type :filers

  attributes :ein, :name, :street, :city, :state, :zip
end