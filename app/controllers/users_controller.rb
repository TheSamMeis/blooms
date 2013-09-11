class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
     # Is email blank?
    if (params[:email].blank?) 
      render :new
      flash[:notice] = "You must enter an email address"
    else
    
       if (params[:first_name].blank?)       
         render :new
         flash[:notice] = "What's your name pretty lady?"
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
                    redirect_to user_orders_path(@user.id)
                else
                # If auth fails, render login page with error
                flash.now[:error] = "This email is already in use."
                render :new
                end

              else
                # If no, create new user and redirect to account form
               
                @user=User.new
                @user.first_name = params[:first_name]
                @user.email = params[:email]
                @user.password = params[:password]
                @user.save
                session[:user_id] = @user.id
                redirect_to flowers_path
             
              end
    end
  end
end 
end



  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path, status: 303
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user
      # @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:F_name, :string, :L_name, :string, :email, :salt, :fish, :string)
    end
end
