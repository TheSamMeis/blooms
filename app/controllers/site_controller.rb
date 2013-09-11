class SiteController < ApplicationController
  
  def subscribe
    @subscription = Subscription.new
  end

   def subscribe_create

    @user=current_user

    @subscription = Subscription.new
    @subscription.subscription_type = params[:subscription][:subscription_type]
    @subscription.subscription_frequency = params[:subscription][:subscription_frequency]
    @subscription.start_date = params[:subscription][:start_date]
    @subscription.user_id =  @user.id 
    @subscription.next_shipment = @subscription.start_date - 7.day
    @subscription.save
    session[:subscription_id] = @subscription.id
    @plan = params[:subscription][:subscription_frequency]
    redirect_to new_ship_address_path(:plan => @plan)
  

    @date_now = Date.today
     # @subscription.next_shipment = @subscription.start_date

  end
  






  def index
  end



  def privacy
  end

  def terms
  end
end