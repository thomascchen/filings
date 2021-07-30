require 'rails_helper'

RSpec.describe Filer, type: :model do
  describe "validations" do
    it { should validate_presence_of(:ein) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validates_uniqueness_of(:ein) }
  end
end
