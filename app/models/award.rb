class Award < ApplicationRecord
  belongs_to :filer
  belongs_to :filing
  belongs_to :receiver

  validates :cash_amount, presence: true, numericality: true
  validates :purpose, presence: true

  def cash_amount_gbp
    (cash_amount * gbp_current_rate).round(2)
  end

  def gbp_current_rate
    FetchGbpCurrencyRate.call
  end
end
