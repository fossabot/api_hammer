require 'api_hammer/version'

module ApiHammer
  autoload :Rails, 'api_hammer/rails'
  autoload :RequestLogger, 'api_hammer/request_logger'
  autoload :ShowTextExceptions, 'api_hammer/show_text_exceptions'
  autoload :TrailingNewline, 'api_hammer/trailing_newline'
  autoload :Weblink, 'api_hammer/weblink'
  autoload :FaradayOutputter, 'api_hammer/faraday/outputter'
  autoload :FaradayCurlVOutputter, 'api_hammer/faraday/outputter'
  module Faraday
    autoload :RequestLogger, 'api_hammer/faraday/request_logger'
  end
end

require 'faraday'
if Faraday.respond_to?(:register_middleware)
  Faraday.register_middleware(:request, :api_hammer_request_logger => proc { ApiHammer::Faraday::RequestLogger })
end
if Faraday::Request.respond_to?(:register_middleware)
  Faraday::Request.register_middleware(:api_hammer_request_logger => proc { ApiHammer::Faraday::RequestLogger })
end
