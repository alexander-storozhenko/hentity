require_relative 'types'
module Hentity
  module TypeCheck

    def check_types!(hash, fields_params)
      hash.each do |k, v|
        type, klass, config = *fields_params[k].values

        check_method = "#{type}_check"

        check_result =
          if respond_to? check_method
            send(check_method, klass, v.class, config)
          else
            default_check(klass, v.class, config)
          end

        raise "Type error" unless check_result
      end
    end

    def float_check(f_klass, v_klass, config)
      return f_klass == v_klass if config.fetch(:exactly, false)

      [f_klass, Integer].include?(v_klass)
    end

    def default_check(f_klass, v_klass, _config)
      f_klass == v_klass
    end
  end
end