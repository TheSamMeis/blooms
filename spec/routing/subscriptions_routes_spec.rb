require 'spec_helper' 

describe 'subscriptions resource' do
	it 'routes /dashboard to subscriptions#index' do 
		expect(get: '/dashboard').to route_to(
				controller: 'subscriptions',
				action: 'index'
		)
	end
end



