require 'rails_helper'
require 'spec_helper'

RSpec.describe SessionsController, type: :controller do
    
    before do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    end
    
    describe "#create" do

        it 'should successfully create a user' do
            expect {
                post :create, provider: :google
            }. to change{User.count}.by(1)
            #expect(controller).to receive(:create).and_return() 
        end

        it "should successfully create a session" do 
            session[:user_id].should be_nil
        end
        
=begin
        it "should redirect user to root path" do
            post :create, provider: :google
            response.should redirect_to root_path
        end
=end
    end
    
    describe "#destroy" do
        it "should redirect to login" do
            delete :destroy
            response.should redirect_to :login
        end
    end
    
end