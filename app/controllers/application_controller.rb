class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, if: :devise_controller?
    helper_method :is_friend
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
  
  def is_friend(id1,id2) #checking already friend or request sent or recieved
    (Friendship.where(sent_by_id:id1,sent_to_id:id2,status:true).exists?) || (
        Friendship.where(sent_to_id:id1,sent_by_id:id2,status:true).exists?) 
end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end
end
