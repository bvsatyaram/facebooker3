class FacebookerauthController < ActionController::Base
  skip_before_filter :authorization_required, :only => [:authorize, :callback]
  
  def authorize
    # TODO: Skip authorization if no default permissions exist
    @reauthorize = (params[:authorized] == "false")
    @authorization_url = oclient.web_server.authorize_url(:redirect_uri => facebookerauth_callback_url, :scope => Facebooker3.facebooker3_config["default_permissions"])
  end

  def callback
    if params[:error]
      redirect_to (ENV['FACEBOOK_APP_URL'] + "facebookerauth/authorize?authorized=false")
    else
      #FIXME: The following call is throwing an exception:
      # OAuth2::HTTPError Exception: Received HTTP 400 during request.
      oauth_response = oclient.web_server.get_access_token(params[:code], :redirect_uri => facebookerauth_callback_url)
      session[:fb_access_token] = oauth_response.token
      redirect_to ENV['FACEBOOK_APP_URL']
    end
  end

  protected

  def oclient
    @oclient ||= OAuth2::Client.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET_KEY'], :site => ENV['GRAPH_URL'])
  end
end
