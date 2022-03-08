require_relative 'type_list'

module Types
  include TypeList

  @@field_types = {}

  def field_types
    @@field_types
  end

  def initialize_types
    types.each do |type, klass|
      define_singleton_method type do |field, kwargs = {}|
        caller_class = caller[0][/`.*'/][8..-3]
        (@@field_types[caller_class] ||= {})[field] = klass
      end
    end
  end
end
