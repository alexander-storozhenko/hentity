module Hentity
  KNOWN_TYPES = {
    integer: Integer,
    string: String,
    float: Float,
    boolean: [TrueClass, FalseClass],
    array: Array
  }.freeze

  module Types
    def integer(field = nil, require: false, **kwargs); end

    def string(field = nil, require: false, **kwargs); end

    def float(field = nil, require: false, exactly: false, **kwargs); end

    def boolean(field = nil, require: false, **kwargs); end

    def array(field = nil, type: nil, require: false, **kwargs); end
  end
end