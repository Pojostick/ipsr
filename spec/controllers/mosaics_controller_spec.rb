require 'rails_helper'

RSpec.describe MosaicsController, type: :controller do
    # let(:m) {Mosaic.create()} # Create a Mosaic object
    
    before (:each) do
      get 'new'
    end
    
    it "should be able to load index for nonexistant mosaic" do
      params = {}
      expect{ get 'index' }.not_to raise_error
    end
    
    it "should do elegantly handle calling new twice" do
      get 'new'
    end
    
    it "should be able load index for existing mosaic" do
      params = {mosaic_id: 1}
      expect{ get 'index', params}.not_to raise_error
    end
    
    it "should be able to show for an existing mosaic" do
      expect{ get 'show', {id: 1}}.not_to raise_error
    end
    
    it "should be able to autosave" do
      expect{ get 'autosave', {:mosaic_id => 1, :time => "1", :tileId => "1", :color => "#302988"}}.not_to raise_error
    end
    
end
