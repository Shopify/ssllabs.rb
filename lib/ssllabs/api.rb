require 'active_support/core_ext/hash'
require 'net/http'
require 'socksify/http'

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
      uri = URI("#{API_LOCATION}#{name}?#{URI.encode_www_form(params)}")
      r = nil
      proxy = nil
      if ENV['http_proxy']
        uri_proxy = URI.parse(ENV['http_proxy'])
        proxy_user, proxy_pass = nil
        proxy_user, proxy_pass = uri_proxy.userinfo.split(/:/) if uri_proxy.userinfo
        proxy = Net::HTTP::Proxy(uri_proxy.host,uri_proxy.port,proxy_user,proxy_pass)
      elsif ENV['socks_proxy']
        uri_proxy = URI.parse(ENV['socks_proxy'])
        proxy_user, proxy_pass = nil
        proxy_user, proxy_pass = uri_proxy.userinfo.split(/:/) if uri_proxy.userinfo
        proxy = Net::HTTP::SOCKSProxy(uri_proxy.host,uri_proxy.port,proxy_user,proxy_pass)
      end
      if proxy.nil?
        r = Net::HTTP.get_response(uri)
      else
        r = proxy.get_response(uri)
      end
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
