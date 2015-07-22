require 'faraday/specific_loging'

if Faraday.respond_to?(:register_middleware)
  Faraday.register_middleware specific_loging: Faraday::SpecificLogging
elsif Faraday::Middleware.respond_to?(:register_middleware)
  Faraday::Middleware.register_middleware specific_loging: Faraday::SpecificLogging
end
