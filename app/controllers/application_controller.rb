class ApplicationController < ActionController::Base
	 #ここから追加
	 before_action :configure_permitted_parameters, if: :devise_controller?
	def after_sign_in_path_for(resource)
	     user_path(current_user.id)
	end

    def after_sign_out_path_for(resource)
	      root_path
    end

  # 下記を追加

 protected
 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
   devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
   devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end
