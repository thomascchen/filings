class AwardSerializer
  include JSONAPI::Serializer

  set_type :awards

  attributes :cash_amount, :cash_amount_gbp, :purpose
  
  belongs_to :receiver
end