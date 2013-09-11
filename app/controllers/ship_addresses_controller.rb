
  class ShipAddressesController < ApplicationController


  	def new
  		
  		@ship_address = ShipAddress.new
  		@user= current_user
      @plan = params[:plan]
  

  	end


  	def create

  		  @ship_address=ShipAddress.new(ship_address_params)
        @ship_address.save

        @plan = params[:ship_address][:plan]
        current_subscription.ship_address_id = @ship_address.id

        puts current_subscription.ship_address_id
        current_subscription.save

      	redirect_to new_checkout_path(:plan => @plan)
        @user = current_user

       


  	end

    def edit
      @ship_address = ShipAddress.find params[:id]
      @user_id = @ship_address.user_id
      @user = User.where(:id => @user_id)
      session[:return_to] ||= request.referer

    end

    def update

     @ship_address = ShipAddress.find params[:id]
    @ship_address.update_attributes(ship_address_params)
    redirect_to session.delete(:return_to), status: 303


    end


def ship_address_params
  params.require(:ship_address).permit :company, :address1, :address2, :city, :state, :postalcode, :user_id
end


def us_states
   @us_states= [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]
end
  end