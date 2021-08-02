require 'rails_helper'

RSpec.describe Filer, type: :model do
  describe "associations" do
    it { should have_many(:filings) }
    it { should have_many(:awards).through(:filings).conditions("distinct") }
  end

  describe "validations" do
    subject { Filer.new(ein: "ein", name: "name") }
    it { should validate_presence_of(:ein) }
    it { should validate_presence_of(:name) }
  end
end
