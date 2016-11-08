require 'rails_helper'

RSpec.describe MosaicsController, type: :controller do
<<<<<<< HEAD
    it "should autosave every 5 seconds" do
      #setup a mock with no colors
      #autosave
      #add in a new tile
      #autosave
      #there should be a new tile
    end
end
=======
    # it "should autosave every 5 seconds" do
    #   #setup a mock with no colors
    #   #autosave
    #   #add in a new tile
    #   #autosave
    #   #there should be a new tile
    # end
    describe "Post autosave" do 
        before(:each) do 
            @fake_mosaic = double('Mosaic', :steps => Array.new, :grid => "", :step_count => 0)
            @args = {:mosaic_id => "01", :time => Time.now.asctime, :tileId => "0", :color => "8060930"}
            expect(Mosaic).to receive(:find).with("01").and_return(@fake_mosaic)
        end
         
        it "should create add a tile with color '8060930' in a grid" do
             expect(@fake_mosaic).to receive(:update_attributes!).with({:steps => [{ timestamp: @args[:time], tileId: @args[:tileId], color: @args[:color]}]})
             expect(@fake_mosaic).to receive(:update_attributes!).with({:grid => @args[:color]})
             post :autosave, @args
             expect(assigns(:mosaic)).to eq(@fake_mosaic)
             # expect(@fake_mosaic.grid).to match(/^8060930$/)
             expect(response).to render_template(root_path) 
        end
    end		
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
      expect{ get 'autosave', {:mosaic_id => 1, :time => Time.now.asctime, :tileId => "1", :color => "#302988"}}.not_to raise_error
    end
end		 


>>>>>>> 016266322903d7b312f75ddbfbb915b74bb4863a
