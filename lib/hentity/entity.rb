require_relative 'types'
require_relative 'type_check'
require_relative 'config_check'

module Hentity
  class Entity
    include Types

    extend TypeCheck
    extend ConfigCheck

    attr_reader :hash

    def []=(key, value)
      @hash[key] = value

      check_rules(@hash)
    end

    def initialize(hash)
      @hash = hash
      self.class.check_rules(@hash)
    end

    class << self
      attr_accessor :fields_params
      attr_accessor :errors

      def check_rules(hash)
        check_global_config!(hash, @fields_params)
        check_types!(hash, @fields_params)
      end
    end
  end

  KNOWN_TYPES.each do |type, klass|
    Entity.define_singleton_method type do |field, config = {}|
      (@fields_params ||= {})[field] = { type: type, klass: klass, config: config }
    end
  end
end