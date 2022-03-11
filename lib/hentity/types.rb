module Hentity
  KNOWN_TYPES = {
    integer: Integer,
    string: String,
    float: Float,
    boolean: [TrueClass, FalseClass],
  }.freeze

  module Types
    def integer(field, require: false, **kwargs); end

    def string(field, require: false, **kwargs); end

    def float(field, require: false, exactly: false, **kwargs); end

    def boolean(field, require: false, **kwargs); end
  end
end