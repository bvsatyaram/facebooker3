module Facebooker3
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

      @facebooker3_configuration = config
      facebooker3_config
    end

    def facebooker3_config
      @facebooker3_configuration
    end
  end
end

require 'facebooker3/logging'