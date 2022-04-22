module Hentity
  module Errors
    class ConfigError < StandardError

      def initialize(msg)
        super
        Hentity::Logger.error(msg)
      end
    end
  end
end
