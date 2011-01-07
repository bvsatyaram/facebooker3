require 'base64'
require 'openssl'

module Facebooker3::FacebookSignedRequest
  def self.valid?(signed_request, secret = ENV['FACEBOOK_SECRET_KEY'])
    return false if signed_request.nil?
    
    encoded_sign, payload = signed_request.split('.')
    sign = str_to_hex(base64_url_decode(encoded_sign))

    data = ActiveSupport::JSON.decode base64_url_decode(payload)
    if data['algorithm'].to_s.upcase != 'HMAC-SHA256'
      return false
    end

    expected_sig = OpenSSL::HMAC.hexdigest('sha256', secret, payload)
    if expected_sig != sign
      return false
    end

    return true
  end

  protected

  def self.base64_url_decode(str)
    encoded_str = str.gsub('-','+').gsub('_','/')
    encoded_str += '=' while !(encoded_str.size % 4).zero?
    Base64.decode64(encoded_str)
  end

  def self.str_to_hex(string)
    (0..(string.size-1)).to_a.map do |i|
      number = string[i].to_s(16)
      (string[i] < 16) ? ('0' + number) : number
    end.join
  end
end