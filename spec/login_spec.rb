require 'spec_helper'

describe 'Home Page' do
	it "should have content" do
		visit "/"
		expect(page).to have_link("SUBSCRIBE");
	end
end 