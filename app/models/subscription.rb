class Subscription < ActiveRecord::Base
 require "comma"
 # before_save :calculate_next_ship

  # ================
   # = Associations =
   # ================
	belongs_to :user
  belongs_to :ship_address




  # comma is a gem that allows me to export to csv
 comma do
 	  subscription_type
    subscription_status
    next_shipment
    ship_address :company
 		ship_address :first_name
    ship_address :last_name
    ship_address :address1
    ship_address :address2
    ship_address :city	
    ship_address :state
    ship_address :postalcode
    ship_address :country

  end

  #changes order status to expired when push notification come from recurly

	def expire
	  self.subscription_status="expired"
	  self.save
	end

	def active 
		self.subscription_status="active"
		self.save
	end
	
	def declined 
		self.subscription_status="declined"
		self.save
	end

	def frequency_pretty
		if self.subscription_frequency == '2week'
			self.subscription_frequency = '2 Weeks'


		elsif self.subscription_frequency == '4week'
			self.subscription_frequency = '4 Weeks'
	

		elsif self.subscription_frequency == 'holiday'
			self.subscription_frequency = 'Major Holiday'
		end
	end
	

	#calculates next ship date for 
	def calculate_next_ship 
		calculated_date=Date.new
		if self.next_shipment != nil
		if self.next_shipment < Date.today
			if subscription_frequency == "4week"
				calculated_date = self.next_shipment + 28.day
				self.next_shipment = 	calculated_date		
			end
				if subscription_frequency == "2week"
				calculated_date = self.next_shipment + 14.day
				self.next_shipment = 	calculated_date		
			end
		end
		end
	end

end