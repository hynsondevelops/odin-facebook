class RegistrationsController <  Devise::RegistrationsController
    def create
    	UserMailer.new_user(params[:user]).deliver_now
    	super
    end
end
