class FilingSerializer < BaseSerializer
  set_type :filings

  attributes :tax_year, :amended, :average_grant_size, :top_categories

  belongs_to :filer
  has_many :awards
  has_many :receivers
end