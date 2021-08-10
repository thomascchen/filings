class FilingSerializer < BaseSerializer
  set_type :filings

  attributes :tax_year, :amended

  belongs_to :filer
  has_many :awards
end