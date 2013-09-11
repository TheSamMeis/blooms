class ShipAddress < ActiveRecord::Base
	belongs_to :user
	
	attr_accessor :plan


end
