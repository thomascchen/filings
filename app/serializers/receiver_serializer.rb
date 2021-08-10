class ReceiverSerializer < BaseSerializer
  set_type :receivers

  attributes :ein, :name, :street, :city, :state, :zip
end
