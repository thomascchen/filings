class AwardSerializer
  include JSONAPI::Serializer

  set_type :awards

  attributes :cash_amount, :purpose
  
  belongs_to :receiver
end