require 'rails_helper'

RSpec.describe Filing, type: :model do
  describe "associations" do
    it { should belong_to(:filer) }
    it { should belong_to(:filer_address).class_name("Address") }
  end

  describe "validations" do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:xml) }
  end
end
