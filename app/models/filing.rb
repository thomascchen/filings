class Filing < ApplicationRecord
  belongs_to :filer
  has_many :awards
  has_many :receivers, -> { distinct }, through: :awards

  validates :tax_year, presence: true, numericality: true
  validates :url, presence: true
  validates :xml, presence: true

  def average_grant_size
    awards.average(:cash_amount)
  end

  def top_categories
    awards.pluck(:purpose).tally.sort { |a, b| b.last <=> a.last }.first(3).map { |x| x.first }
  end
end
