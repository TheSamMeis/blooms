require 'spec_helper'

feature "show subscription line items" do 
	scenario "admin visits subscritions page" do
		visit admin_subscriptions_path

		expect(current_path).to eql dashboard_path
		expect(page).to have_content 'subscriptions admin view'
		


	end
end