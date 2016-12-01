require 'rails_helper'
require 'spec_helper'

RSpec.describe Mosaic, type: :model do
    it "should have 22 colors" do
      expect(Mosaic.colors).to have(22).items
    end
    
    it "should have to_csv method" do
      expect(Mosaic.to_csv).to have(104).items
    end
    
end