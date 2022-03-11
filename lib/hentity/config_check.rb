module Hentity
  module ConfigCheck

    def check_global_config!(hash, field_params)
      field_params.each do |field, params|
        @hash = hash

        @type, @klass, @config = *params.values

        field_require!(field)
      end
    end

    def field_require!(field)
      if @config.fetch(:require, false)
        raise Hentity::Errors::TypeError, 'Field required!' unless @hash.keys.include?(field)
      end
    end
  end
end