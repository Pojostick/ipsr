require 'rails_helper'
require 'spec_helper'

RSpec.describe MosaicsController, type: :controller do
    describe "Post autosave" do 
        before(:each) do 
            session[:user_id] = 123
            @fake_mosaic = double('Mosaic', :steps => Array.new, :grid => "", :step_count => 0, :grids => Array.new, :user => 123)
            @args = {:mosaic_id => "01", :time => Time.now.asctime, :tileId => "0", :color => "8060930"}
            expect(Mosaic).to receive(:find).with("01").and_return(@fake_mosaic)
        end
         
        it "should create add a tile with color '8060930' in a grid" do
             expect(@fake_mosaic).to receive(:update_attributes!).with({:steps => [{ timestamp: @args[:time], tileId: @args[:tileId], color: @args[:color]}]})
             expect(@fake_mosaic).to receive(:update_attributes!).with({:grid => @args[:color]})
             expect(@fake_mosaic).to receive(:update_attributes!).with({:grids => [@args[:color]]})
             expect(@fake_mosaic).to receive(:increment).with(:step_counter, 1)
            #  expect(@fake_mosaic.step_counter).to eq(1)
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
    
    it "should block unauthorized users from viewing other mosaics" do
        session[:user_id] = 0
        get 'show', {id: 1}
        expect(response.body).to eq "<html>You do not have permissions to view this mosaic.</html>"
    end
    
    it "should be able to autosave" do
      expect{ get 'autosave', {:mosaic_id => 1, :time => Time.now.asctime, :tileId => "1", :color => "#302988"}}.not_to raise_error
    end
    
    it "paginates records" do
        expect{ get 'gallery'}.not_to raise_error
    end
    
    describe "Download Mosaic" do 
        before :each do
            @mock_mosaic = double('Mosaic', {:steps => '[]', :grid => 'transparent'})
        end
        it "should be able to download all mosaics" do
            expect(Mosaic).to receive(:all).and_return(@mock_mosaic)
            expect(@mock_mosaic).to receive (:to_csv)
            post :download_all, {:format => :csv}
        end
        
        it "should be able to download selected mosaics" do
            expect(Mosaic).to receive(:where).with({:id=>["id"]}).and_return(@mock_mosaic)
            expect(@mock_mosaic).to receive (:to_csv)
            post :download_gallery, {:format => :csv, :mosaics => {:id => '1'}}
        end
        
        it "should not be able to download selected mosaics without selected any mosaic" do
            post :download_gallery, {:mosaics => nil}
            response.should redirect_to(gallery_path)
        end
        
        it "should have pagination" do
            # expect(Mosaic.all).to receive(:paginate).with(no_args)
            expect(Mosaic).to receive(:all).and_return(@mock_mosaic)
            expect(@mock_mosaic).to receive(:paginate).with({:page=>"9", :per_page=>9})
            get :gallery, {:page => 9, per_page: 9}
        end
    end
    
    describe "Gallery" do 
        it "should check mosaics" do
            params = {:checked => "fake mosaic data"}
            get :gallery
            expect(:checked_mosaics).to be_truthy
        end
        
        it "should not complete mosaics" do 
            params = {:completed => "nil"}
            get :gallery
            #expect(:check).to be_falsey
        end
        
        it "should complete mosaics" do 
            session[:user_id] = 123
            params = {:completed => "true"}
            get :gallery
            expect(:check).to be_truthy
            #expect(Mosaic).to receive(:where).with({:completed => "true", :user => "123"})
            #assigns(:mosaics).should be_a Mosaic
        end
        
        it "should check if numcolors" do
            session[:user_id] = 123
            @fake_mosaic = double('Mosaic', :steps => Array.new, :grid => "", :step_count => 3, :grids => Array.new, :user => 123)
            get :gallery, params: {:numcolors => 3, :completed => false}
            assigns(:mosaics).should_not be_nil
            expect(Mosaic).to receive(:where)#.with({:step_counter=>["3"]}).and_return(@fake_mosaic)
        end
        
        it "should check if nummoves" do 
            get :gallery, params = {:nummoves => 4, :completed => false}
            assigns(:movenum).should eq("4")
            assigns(:mosaics).should_not be_nil
            #expect(Mosaic).to receive(:where).with({:id=>["id"]}).and_return(@mock_mosaic)
        end
        
        it "should check if dominant" do 
            get :gallery, params = {:dominant => "some_color"}
            assigns(:mosaics).should_not be_nil
        end
    end
    
    #describe "Mosaic params" do
        #it "should require mosaic and permit things" do
            #should permit(:grid, :steps, :step_counter, :grid_array, :completed, :number_of_colors, :dominant_color)
        
end		 
