require 'faraday'
require 'faraday_middleware'

module Faraday
  class SpecificLogging < Faraday::Middleware
    VERSION = '0.1.1'

    def initialize(app, options = {})
      super(app)
      @logger = options[:logger]
      @call_logging  = options[:call_logging] || 'info'
      @target_key = options[:target_key]
      @message = options[:message] || ''
    end

    def call(env)
      return @app.call(env) if lost_options? || not_post_or_put?(env) || env.body.nil?

      request_body = parse_body(env)

      @logger.send(@call_logging, message: @message, @target_key.to_sym => request_body[@target_key.to_s])

      @app.call(env)
    end

    private

    def lost_options?
      @logger.nil? || @target_key.nil?
    end

    def not_post_or_put?(env)
      [:put, :post].exclude?(env[:method])
    end

    def parse_body(env)
      # NOTE Try parse to JSON.
      JSON.load(env.body)
    rescue JSON::ParserError, TypeError
      url_encoded_params_to_hash(env.body)
    end

    def url_encoded_params_to_hash(string)
      string.split('&').each_with_object({}) {|str, hs|
        key, value = str.split('=')

        hs[key.to_s] = value
      }
    end
  end
end
