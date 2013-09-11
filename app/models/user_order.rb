	def frequency_pretty
		if self.subscription_frequency == '2week'
			self.subscription_frequency = '2 Weeks'
		end
		
		if self.subscription_frequency == '4week'
			self.subscription_frequency = '4 Weeks'
		end

		if self.subscription_frequency == 'holiday'
			self.subscription_frequency = 'Major Holiday'
		end
	end