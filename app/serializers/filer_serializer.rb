class FilerSerializer < BaseSerializer
  set_type :filers

  attributes :ein, :name, :street, :city, :state, :zip
end