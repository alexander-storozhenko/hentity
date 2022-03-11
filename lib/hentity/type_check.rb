module Hentity
  module TypeCheck

    def check_types!(hash, fields_params)
      hash.each do |k, v|
        type, klass, config = *fields_params[k].values
        value_class = v.class

        check_method = "#{type}_check"

        check_result =
          if respond_to? check_method
            send(check_method, klass, value_class, config)
          else
            default_check(klass, value_class, config)
          end

        unless check_result
          raise Hentity::Errors::TypeError,
                "value {#{v}} class is #{value_class} but model specified by #{klass}"
        end
      end
    end

    def float_check(f_class, v_class, config)
      return f_class == v_class if config.fetch(:exactly, false)

      [f_class, Integer].include?(v_class)
    end

    def boolean_check(f_class, v_class, _config)
      f_class.include?(v_class)
    end

    def default_check(f_klass, v_class, _config)
      f_klass == v_class
    end
  end
end