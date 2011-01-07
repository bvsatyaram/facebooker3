module FacebookerauthHelper
  def authorization_redirection_js
    "top.location.href = '#{@authorization_url}'"
  end
end