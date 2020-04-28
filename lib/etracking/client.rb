require 'uri'
require 'net/http'
require 'json' 

module Etracking

  # API Client of eTracking SDK for Ruby
  #
  #   @client ||= Etracking::Client.new do |config|
  #      config.api_key = ENV["etracking_api_key"]
  #      config.key_secret = ENV["etracking_key_secret"]
  #      config.language = ENV["etracking_language"] || 'TH'
  #   end
  
  class Client
    #  @return [String]
    attr_accessor :api_key, :key_secret, :language, :thailand_post_api_key

    # Initialize a new client.
    #
    # @param options [Hash]
    # @return [Etracking::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    def endpoint
      'https://etrackings.com/api/v2/tracks/'
    end

    def headers(request)
      api_key_required
      key_secret_required

      request['etracking-api-key'] = api_key
      request['etracking-key-secret'] = key_secret
      request['accept-language'] =  language || 'TH'
      request['content-type'] = 'application/json'

      request
    end

    def rest_api(path, payload)
      url = URI("#{endpoint}#{path}")

      http = Net::HTTP.new(url.host, url.port);
      request = Net::HTTP::Post.new(url)
      request = headers(request)
      request.body = payload.to_json

      response = http.request(request)
      JSON.parse(response.read_body, { symbolize_names: true } )
    end

    def track(service_name, tracking_number)
      rest_api('/find', payload_with_service_and_tracking_number(service_name, tracking_number))
    end

    def dhl_express(tracking_number)
      rest_api('/dhl_express', payload_tracking_number(tracking_number))
    end

    def flash_express(tracking_number)
      rest_api('/flash_express', payload_tracking_number(tracking_number))
    end

    def jt_express(tracking_number)
      rest_api('/jt_express', payload_tracking_number(tracking_number))
    end

    def kerry_express(tracking_number)
      rest_api('/kerry_express', payload_tracking_number(tracking_number))
    end
    
    def lazada_express(tracking_number)
      rest_api('/lazada_express', payload_tracking_number(tracking_number))
    end

    def scg_express(tracking_number)
      rest_api('/scg_express', payload_tracking_number(tracking_number))
    end

    def shopee_express(tracking_number)
      rest_api('/shopee_express', payload_tracking_number(tracking_number))
    end

    def thailand_post(tracking_number)
      thailand_post_api_key

      api('thailand_post', payload_tracking_number(tracking_number))
    end

    def payload_with_service_and_tracking_number(service_name, tracking_number)
      {
        service_name: service_name,
        tracking_number: tracking_number
      }
    end

    def payload_tracking_number(tracking_number)
      {
        tracking_number: tracking_number
      }
    end

    private

    def api_key_required
      raise ArgumentError, '`api_key` is not configured' unless api_key
    end

    def key_secret_required
      raise ArgumentError, '`key_secret` is not configured' unless key_secret
    end

    def thailand_post_api_key_required
      raise ArgumentError, '`thailand_post_api_key` is not configured' unless thailand_post_api_key
    end
  end
end