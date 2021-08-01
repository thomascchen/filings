class AddTaxYearToFilings < ActiveRecord::Migration[6.1]
  def change
    add_column :filings, :tax_year, :integer, null: false
    add_column :filings, :amended, :boolean, default: false
  end
end
