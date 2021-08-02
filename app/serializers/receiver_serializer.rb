class ReceiverSerializer
  include JSONAPI::Serializer

  set_type :receivers

  attributes :ein, :name, :street, :city, :state, :zip
end
