module Hentity
  module TypeCheck
    include ArrayConfig

    def check_types!(hash, fields_params)
      hash.each do |k, v|
        type, klass, config = *fields_params[k].values

        field_params = { type: type, f_klass: klass, value_class: normalize_class(v), config: config }

        result = check_for_hash(type, field_params)

        unless result
          raise Hentity::Errors::TypeError,
                "value {#{v}} class is #{field_params[:value_class]} but model specified by #{klass}"
        end
      end
    end

    def check_for_hash(type, field_params)
      check_method = "#{type}_check"
      if respond_to? check_method
        send(check_method, field_params)
      else
        default_check(field_params)
      end
    end

    def check_for_enumerable(type, field_params)
      check_method = "#{type}_check"

      if respond_to? check_method
        send(check_method, field_params)
      else
        default_check(field_params)
      end
    end

    def float_check(f_class, v_class, config)
      return f_class == v_class if config.fetch(:exactly, false)

      [f_class, Integer].include?(v_class)
    end

    def boolean_check(field_params)
      field_params[:f_class].include?(field_params[:value_class])
    end

    def array_check(field_params)
      check_array_config(field_params)
      true
    end

    def custom_check(field_params)
      field_params[:f_klass] == field_params[:v_class]
    end

    def default_check(field_params)
      if field_params[:f_klass] == Array
        # TODO: to ArrayConfig module
        return field_params[:config][:types].all? do |t|
          field_params[:value_class].include?(t)
        end
      end

      field_params[:f_klass] == field_params[:value_class]
    end

    def normalize_class(value)
      return value.class unless value.is_a? Enumerable

      value.map(&:class)
    end
  end
end