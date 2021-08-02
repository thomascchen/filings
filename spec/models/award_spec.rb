
require 'rails_helper'

RSpec.describe Award, type: :model do
  describe "associations" do
    it { should belong_to(:filer) }
    it { should belong_to(:filing) }
    it { should belong_to(:receiver) }
  end

  describe "validations" do
    it { should validate_presence_of(:cash_amount) }
    it { should validate_presence_of(:purpose) }
    it { should validate_numericality_of(:cash_amount) }
  end
  
  describe "#cash_amount_gbp" do
    it "should be tested :)"
  end

  describe "#gbp_current_rate" do
    it "should be tested :)"
  end
end
