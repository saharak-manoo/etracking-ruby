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
    attr_accessor :api_key, :key_secret, :language

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
      'https://etrackings.com/api/v2/tracks'
    end

    def rest_api(path, payload)
      api_key_required
      key_secret_required

      url = URI("#{endpoint}#{path}")

      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["etracking-api-key"] = api_key
      request["etracking-key-secret"] = key_secret
      request["accept-language"] = language || 'th'
      request["content-type"] = ["application/json", "text/plain"]
      request.body = payload.to_json
      response = https.request(request)

      JSON.parse(response.read_body, { symbolize_names: true } )
    end

    def auto_detect(tracking_numbers = [])
      rest_api('/auto_detect', payload_tracking_number(tracking_number))
    end

    def tracks(courier, tracking_numbers = [])
      rest_api('', payload_with_courier_and_tracking_numbers(courier, tracking_number))
    end

    def track(courier, tracking_number)
      rest_api('/find', payload_with_courier_and_tracking_number(courier, tracking_number))
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
      rest_api('/thailand_post', payload_tracking_number(tracking_number))
    end

    def payload_with_courier_and_tracking_numbers(courier, tracking_numbers)
      {
        courier: courier,
        tracking_numbers: tracking_numbers
      }
    end

    def payload_with_courier_and_tracking_number(courier, tracking_number)
      {
        courier: courier,
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
  end
end