require 'rest-client'
require 'securerandom'

module Etracking

  # API Client of eTracking SDK for Ruby
  #
  #   @client ||= Etracking::Client.new do |config|
  #      config.api_key = ENV["etracking_api_key"]
  #      config.key_secret = ENV["etracking_key_secret"]
  #      config.language = ENV["etracking_language"] || 'TH'
  #      config.is_develop = ENV["is_develop"] || true
  #      config.thailand_post_api_key = ENV['thailand_post_api_key']
  #   end
  
  class Client
    $TRACKS_PATH = "api/v2/tracks"

    #  @return [String]
    attr_accessor :api_key, :key_secret, :language, :is_develop, :thailand_post_api_key

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
      if is_develop.nil? || is_develop == true
        @endpoint = "http://165.22.52.6/"
      else
        @endpoint = "https://etrackings.com/"
      end
    end

    def rest_client_api(url, method, headers, payload)
      response = RestClient::Request.new({
        url: url,
        method: method.to_sym,
        headers: headers,
        payload: payload.to_json
      }).execute do |response, request, result|
        return JSON.parse(response.to_str)
      end
    end

    def headers
      api_key_required
      key_secret_required

      {
        etracking_api_key: api_key,
        etracking_key_secret: key_secret,
        content_type: 'application/json', 
        accept_language: language || 'TH'
      }
    end

    def api(service, tracking_number)
      rest_client_api(
        "#{endpoint}#{$TRACKS_PATH}/#{service}", 
        "post", 
        headers, 
        payload_tracking_number(tracking_number)
      )
    end

    def dhl_express(tracking_number)
      api('dhl_express', tracking_number)
    end

    def flash_express(tracking_number)
      api('flash_express', tracking_number)
    end

    def jt_express(tracking_number)
      api('jt_express', tracking_number)
    end

    def kerry_express(tracking_number)
      api('kerry_express', tracking_number)
    end
    
    def lazada_express(tracking_number)
      api('lazada_express', tracking_number)
    end

    def scg_express(tracking_number)
      api('scg_express', tracking_number)
    end

    def shopee_express(tracking_number)
      api('shopee_express', tracking_number)
    end

    def thailand_post(tracking_number)
      thailand_post_api_key

      api('thailand_post', tracking_number)
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