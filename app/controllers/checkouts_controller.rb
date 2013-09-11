class CheckoutsController < ApplicationController

def new 
   @plan = params[:plan]
  
   @signature = Recurly.js.sign 
   @subdomain = Recurly.subdomain  
   @user = current_user


end
def create
	
		redirect_to root_path

 end



end