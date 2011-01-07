# ActionController::Base extensions
module FacebookRequestValidator
  def request_from_facebook?
    Facebooker3::FacebookSignedRequest.valid?(params[:signed_request])
  end
end

ActionController::Base.send :include, FacebookRequestValidator

module OauthAuthorizer
  def self.included(controller)
    controller.send :include, InstanceMethods
    controller.before_filter :authorization_required
  end

  module InstanceMethods
    def authorization_required
      return true if session[:fb_access_token]
      redirect_to facebookerauth_authorize_path
    end
  end
end

ActionController::Base.send :include, OauthAuthorizer