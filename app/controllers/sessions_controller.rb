class SessionsController < ApplicationController
	respond_to :json
	def create
			puts "***************|Login|*******************"
	    user = User.find_by_email(params[:user][:email])
	    if user.present? && user.valid_password?(params[:user][:password])
	      puts "***************|user presente|*******************"
	      user.update_column(:authentication_token, User.generate_authentication_token)
	      render status: 200, json: {
	        success: true,
	        user: user
	      }
	    else
	      puts "***************|user error|*******************"
	      render :status => 401, json: {
	          success: false,
	          info: "",
	          data: {}
	      }
	    end
	end

	private
    def user_params
      params.require(:user).permit!
    end
end