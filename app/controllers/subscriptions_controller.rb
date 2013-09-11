class SubscriptionsController < ApplicationController
 before_filter :authorize 
  layout "dashboard"
	def index

		@subscriptions=Subscription.all
 

	end

	def index_active
		@subscriptions_active=Subscription.where(:subscription_status => "active") 
	end

# def create 
# 	 @subscription = Subscription.new(subscription_params)
#    @subscription.next_shipment = @subscription.start_date
#    @subscription.save
# 	redirect_to new_ship_address_path
# end


  def subscription_params
  	params.permit(:subscription_type, :subscription_frequency, :start_date)
  end


	def show

		@subscription = Subscription.find params[:id]
		
		account = Recurly::Account.find(@subscription.user_id)
			@billing_info = account.billing_info
		  @billing_first_name = account.first_name
		  @billing_last_name = account.last_name
		  @billing_first_name = account.first_name


		 @type = @subscription.subscription_type
		 @frequency = @subscription.subscription_frequency
		 @status = @subscription.subscription_status
		 @next_shipment = @subscription.next_shipment


		 @shipping_first_name  = @subscription.ship_address.first_name
		 @shipping_last_name = @subscription.ship_address.last_name
		 @shipping_company = @subscription.ship_address.company
		 @shipping_address1 = @subscription.ship_address.address1
		 @shipping_address2 = @subscription.ship_address.address2
		 @shipping_city = @subscription.ship_address.city
		 @shipping_state = @subscription.ship_address.state
		 @shipping_zip = @subscription.ship_address.postalcode


		
	end


	def export
		@subscriptions=Subscription.first

  end

  def export_action
  	@today = Date.today
  	@filename = "Gilded Blooms " + @today.to_s + ".csv"
		@ship_date_input = params[:ship_date]
  	if @ship_date_input == nil
	  	respond_to do |format|
	   		format.csv { render :csv => Subscription.all, :filename => 'books.csv' }
	  	end
  	else
	 		@ship_date_input = params[:ship_date]
	   	respond_to do |format|
	   		format.csv { render :csv => Subscription.where(:next_shipment => @ship_date_input, :subscription_status => 'active'),:filename => @filename }
  		end
  	end
	end


  def update_ship_dates
  	@subscriptions=Subscription.all 
  	@subscriptions.each do |sub|
  		sub.calculate_next_ship
  		sub.save
  	end		
  	redirect_to dashboard_path
	end





end






