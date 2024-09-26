class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { Rails.env.development? }
  before_action :authenticate_user!
  def after_sign_in_path_for(resource)
        stored_location_for(resource) || produtos_path
  end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end


