class UserOrdersController < ApplicationController

def index

@user = current_user
@user_id = current_user.id.to_s 
@status = 'active'
@user_subscriptions = Subscription.where(:user_id => @user_id, :subscription_status => @status)


end

def show
end

end