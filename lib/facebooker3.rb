module Facebooker3
  FACEBOOK_BASE_URL = "http://apps.facebook.com/"
  @facebooker3_configuration = {}
  @raw_facebooker3_configuration = {}

  class << self
    def load_configuration(facebooker3_yaml_file)
      return false unless File.exist?(facebooker3_yaml_file)
      @raw_facebooker3_configuration = YAML.load(ERB.new(File.read(facebooker3_yaml_file)).result)
      if Rails.env
        @raw_facebooker3_configuration = @raw_facebooker3_configuration[Rails.env]
      end
      apply_configuration(@raw_facebooker3_configuration)
    end

    # Sets the Facebook environment based on a hash of options.
    # By default the hash passed in is loaded from facebooker3.yml, but it can also be passed in
    # manually every request to run multiple Facebook apps off one Rails app.
    def apply_configuration(config)
      ENV['FACEBOOK_APP_ID']              = config['app_id']
      ENV['FACEBOOK_API_KEY']             = config['api_key']
      ENV['FACEBOOK_SECRET_KEY']          = config['secret_key']
      ENV['FACEBOOK_RELATIVE_ROOT_URL']   = config['canvas_page_name']
      ENV['FACEBOOK_APP_URL']             = FACEBOOK_BASE_URL + ENV['FACEBOOK_RELATIVE_ROOT_URL'] + "/"
      ENV['GRAPH_URL']                    = "https://graph.facebook.com/"

      @facebooker3_configuration = config
      facebooker3_config
    end

    def facebooker3_config
      @facebooker3_configuration
    end
  end
end

require 'oauth2'
require 'facebooker3/logging'
require 'facebooker3/signed_request'
require 'facebooker3/core_ext'
require "facebooker3/routing"

#%w{ models controllers helpers }.each do |dir|
#  path = File.join(File.dirname(__FILE__), 'app', dir)
#  $LOAD_PATH << path
#  ActiveSupport::Dependencies.autoload_paths << path
#  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
#end
