require 'rails_helper'

RSpec.describe Filing, type: :model do
  describe "associations" do
    it { should belong_to(:filer) }
  end

  describe "validations" do
    it { should validate_presence_of(:tax_year) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:xml) }
    it { should validate_numericality_of(:tax_year) }
  end
end
