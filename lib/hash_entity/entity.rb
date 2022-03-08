require_relative 'types'
require_relative 'type_check'

class Entity
  extend Types
  include TypeCheck

  initialize_types

  attr_reader :hash

  def []=(key, value)
    @hash[key] = value

    check_types(@hash)
  end

  def initialize(hash)
    @hash = hash

    check_types(@hash)
  end

  def check_types(hash)
    hash.each do |field, value|
      klass = self.class.field_types[self.class.to_s]
      next unless klass.keys.include?(field)

      raise "Type error" unless default_check(klass[field], value.class)
    end
  end
end