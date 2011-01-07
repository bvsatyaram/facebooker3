module Facebooker3
  @@logger = nil
  def self.logger=(logger)
    @@logger = logger
  end
  def self.logger
    @@logger
  end

  module Logging
    def self.log_info(message, dump)
      return unless Facebooker3.logger
      log_message = "#{message} #{dump}"
      Facebooker3.logger.info(log_message)
    end
  end
end
