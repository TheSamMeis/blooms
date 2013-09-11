require 'spec_helper'

# to see the administrator view 
# as a user, 
# I must be an administrator

# scenario: 
# navigate to login 
# enter email
# enter password
# click enter
# redirected to admin dashboard

# scenario: 
# navigate to login 
# enter email
# enter password
# click enter
# redirected to customer dashboard


feature "authenticating admin" do 
	scenario "user logs in" do
		visit new_session_path

		fill_in 'email', with: 'samanthakmeis@gmail.com'
		fill_in 'password', with: 'SAM892306'

		click_on('GET STARTED')

		expect(current_path).to eql dashboard_path
		expect(page).to have_content 'subscriptions admin view'
		


	end
end
