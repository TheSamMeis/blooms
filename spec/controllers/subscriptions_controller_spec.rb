require 'spec_helper'


describe SubscriptionsController do 
		describe 'GET index' do 

			it 'returns a succesful response' do 

			get :index
			expect(response).to be_success
		end
	end
end