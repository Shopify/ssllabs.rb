require 'active_support/core_ext/hash'
require 'net/http'

module Ssllabs
  class InvocationError < StandardError; end
  class RequestRateTooHigh < StandardError; end
  class InternalError < StandardError; end
  class ServiceNotAvailable < StandardError; end
  class ServiceOverloaded < StandardError; end

  class Api
    attr_reader :max_assessments, :current_assessments

    def initialize
      @max_assessments = 0
      @current_assessments = 0
    end

    def request(name, params = {})
      name = name.to_s.camelize(:lower)
      uri = URI("#{API_LOCATION}#{name}?#{params.to_query}")
      r = Net::HTTP.get_response(uri)
      if r.code.to_i == 200
        @max_assessments = r['X-Max-Assessments']
        @current_assessments = r['X-Current-Assessments']
        r = JSON.load(r.body)
        if r.key?('errors')
          raise InvocationError, "API returned: #{r['errors']}"
        end
        return r
      end

      case r.code.to_i
      when 400
        raise InvocationError, "invalid parameters"
      when 429
        raise RequestRateTooHigh, "request rate is too high, please slow down"
      when 500
        raise InternalError, "service encountered an error, sleep 5 minutes"
      when 503
        raise ServiceNotAvailable, "service is not available, sleep 15 minutes"
      when 529
        raise ServiceOverloaded, "service is overloaded, sleep 30 minutes"
      else
        raise StandardError, "http error code #{r.code}"
      end
    end

    def info
      Info.load request(:info)
    end

    def analyse(params = {})
      Host.load request(:analyze, params)
    end

    def get_endpoint_data(params = {})
      Endpoint.load request(:get_endpoint_data, params)
    end

    def get_status_codes
      StatusCodes.load request(:get_status_codes)
    end
  end
end
