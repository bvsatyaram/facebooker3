# ActionController::Base extensions
module FacebookRequestValidator
  def request_from_facebook?
    Facebooker3::FacebookSignedRequest.valid?(params[:signed_request])
  end
end

ActionController::Base.send :include, FacebookRequestValidator