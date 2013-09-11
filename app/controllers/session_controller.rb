
  class SessionController < ApplicationController
  # GET /login - user log in form
  def new

  end
 # POST /login - log user in
  def create
    # Is email blank?
    if (params[:email].blank?) 
      render :new
      flash[:notice] = "You must enter an email address"
    else
          
           if (params[:password].blank?)       
             render :new
             flash[:notice] = "What's your password?"
           else
          # If no, does user exist?
          
              if @user = User.find_by(email: params[:email])
      
                if @user.authenticate(params[:email], params[:password])
                # If authenticated, log in and redirect to /
                    puts "Redirecting to root url"
                    session[:user_id] = @user.id

                      if @user.role == 'admin' 
                        redirect_to dashboard_path
                      else
                       redirect_to user_orders_path(@user.id)
                  end
                else
                # If auth fails, render login page with error
               render :new
                flash.now[:error] = "Password is incorrect"
               
                end
            end
         end
        end 
      end


  # GET/DELETE /logout - logs user out
  def destroy
  	#end session and send to login page

  		session[:user_id] = nil
  		redirect_to root_path

  end

end


