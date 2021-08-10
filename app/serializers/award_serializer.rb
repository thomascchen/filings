class AwardSerializer < BaseSerializer
  set_type :awards

  attributes :cash_amount, :purpose
  # looks like I used up my API requests :)
  # attribute :cash_amount_gbp
  
  belongs_to :receiver
end
