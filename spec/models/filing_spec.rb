require 'rails_helper'

RSpec.describe Filing, type: :model do
  describe "validations" do
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:url) }
  end
end
