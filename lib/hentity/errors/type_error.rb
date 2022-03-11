module Hentity
  module Errors
    class TypeError < StandardError

      def initialize(msg)
        super
        Hentity::Logger.error(msg)
      end
    end
  end
end