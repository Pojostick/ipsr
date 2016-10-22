require 'rails_helper'

RSpec.describe MosaicsController, type: :controller do
    # it "should autosave every 5 seconds" do
    #   #setup a mock with no colors
    #   #autosave
    #   #add in a new tile
    #   #autosave
    #   #there should be a new tile
    # end
    describe "Post autosave" do 
        before(:each) do 
            @fake_mosaic = double('Mosaic', :steps => "", :grid => "")
            @args = {:mosaic_id => "01", :time => "", :tileId => "0", :color => "8060930"}
            expect(Mosaic).to receive(:find).with("01").and_return(@fake_mosaic)
        end
         
        it "should create add a tile with color '8060930' in a grid" do
             expect(@fake_mosaic).to receive(:update_attributes!).with({:steps => "#{@fake_mosaic.steps}#{@args[:time]} #{@args[:tileId]} #{@args[:color]},"})
             expect(@fake_mosaic).to receive(:update_attributes!).with({:grid => @args[:color]})
             post :autosave, @args
             expect(assigns(:mosaic)).to eq(@fake_mosaic)
             # expect(@fake_mosaic.grid).to match(/^8060930$/)
             expect(response).to render_template(root_path) 
        end
    end		     
end		 
