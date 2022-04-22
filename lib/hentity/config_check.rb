module Hentity
  module ConfigCheck

    def check_global_config!(hash, field_params)
      @hash = hash

      field_params.each do |field, params|
        @type, @klass, @config = *params.values

        # TODO: check for array too
        field_require!(field)
      end
    end

    def field_require!(field)
      if @config.fetch(:require, false) && !@hash.keys.include?(field)
        raise Hentity::Errors::TypeError, 'Field required!'
      end
    end
  end
end