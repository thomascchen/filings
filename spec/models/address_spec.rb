require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "associations" do
    it { should have_many(:filings).with_foreign_key(:filer_address_id) }
    it { should have_many(:filers).through(:filings).conditions("distinct") }
  end

  describe "validations" do
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end
end
