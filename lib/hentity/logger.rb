require 'colorize'
require 'time'

module Hentity
  class Logger
    class << self
      def configure(config)
        @colorize = config.fetch(:colorize, true)
        @output = config.fetch(:output, :stdout)
        @color_config = { info: {}, success: {}, warn: {}, error: {}, fatal: {} }.merge config.fetch(:color_config, {})
      end

      attr_reader :colors, :output

      # colors in format `colorize` gem

      def info(message)
        out_message(
          'INFO', message,
          {
            type: :light_blue,
            message: :light_white,
            timestamp: :white,
          }.merge(@color_config[:info])
        )
      end

      def success(message)
        out_message(
          'SUCCESS', message,
          {
            type: :light_green,
            message: :green,
            timestamp: :white,
          }.merge(@color_config[:success])
        )
      end

      def warn(message)
        out_message(
          'WARN', message,
          {
            type: :light_yellow,
            message: :yellow,
            timestamp: :white,
          }.merge(@color_config[:warn])
        )
      end

      def error(message)
        out_message(
          'ERROR', message,
          {
            type: :light_red,
            message: :red,
            timestamp: :white,
          }.merge(@color_config[:error])
        )
      end

      def fatal(message)
        out_message(
          'FATAL', message,
          {
            type: :black,
            message: :light_red,
            timestamp: :white,
          }.merge(@color_config[:fatal])
        )
      end

      private

      def out_message(type, message, color_config)
        out =
          if @colorize
            build_colorized(type, message, color_config)
          else
            build(type, timestamp(:white), message)
          end

        case @output
        when :stdout
          $stdout.puts(out)
        end
      end

      def build_colorized(type, message, **config)
        colorized_type = type.concat(':').send(config[:type])
        timestamp = timestamp(config[:timestamp])
        message = message.send(config[:message])

        build(colorized_type, timestamp, message)
      end

      def build(colorized_type, timestamp, message)
        [colorized_type, timestamp, message].join(' ')
      end

      def timestamp(timestamp_color)
        "[#{DateTime.now}]".send(timestamp_color)
      end
    end
  end
end