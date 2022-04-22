module Hentity
  module ArrayConfig
    # {
    #   types: [Integer, String],
    #   mode: :strict | :any
    # }
    def check_array_config(field_params)
      types = field_params[:config][:types]
      mode = field_params[:config][:mode]


      case mode
      when :any
        check_any_types(types)
      else # :strict - default
        check_strict_types(field_params)
      end
    end

    def check_strict_types(field_params)
      config_types = Array(field_params[:config][:types])

      config_types.each do |config_type|
        check_for_hash(config_type[:type], field_params)
      end
    end

    def check_any_types(config_types)
      # config_types = Array(config_types)
      #
      # config_types.each do |type|
      #   send("#{type}_check") unless hentity_type?(type)
      # end
    end

    def hentity_type?(type)
      type.is_a? Hentity::Entity
    end
  end
end