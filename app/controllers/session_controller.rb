class SessionController < ApplicationController

	skip_before_filter :require_user, :only => [:new, :create]

	def new
	end
	
	def create

		@user = Trainer.first(:email => params[:email])
		
		if @user
			session[:user_id] = @user.id
			redirect_to '/pokemons'
		else
			redirect_to login_url
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to login_url
	end
end
