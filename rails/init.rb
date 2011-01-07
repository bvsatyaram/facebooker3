facebook_config = "#{Rails.root.to_s}/config/facebooker3.yml"

require 'facebooker3'
FACEBOOKER = Facebooker3.load_configuration(facebook_config)

# enable logger before including everything else, in case we ever want to log initialization
Facebooker3.logger = ::Rails.logger if ::Rails.logger