require 'rails_helper'

RSpec.describe Mosaic, type: :model do
    it "should have 22 colors" do
      expect(Mosaic.colors).to have(22).items
    end
end
