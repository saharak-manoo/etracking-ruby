require 'uri'
require 'net/http'
require 'json'

module Etrackings
  # API Client of ETrackings SDK for Ruby
  #
  #   @client ||= Etrackings::Client.new do |config|
  #      config.api_key = ENV["etrackings_api_key"]
  #      config.key_secret = ENV["etrackings_key_secret"]
  #      config.language = ENV["etrackings_language"] || 'TH'
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
      'https://fast.etrackings.com/v3/tracks'
    end

    def rest_api(path, payload)
      api_key_required
      key_secret_required

      url = URI("#{endpoint}#{path}")

      https = Net::HTTP.new(url.host, url.port);
      https.use_ssl = true
      https.read_timeout = 12

      request = Net::HTTP::Post.new(url)
      request["Etrackings-api-key"] = api_key
      request["Etrackings-key-secret"] = key_secret
      request["Accept-Language"] = language || 'th'
      request["Content-Type"] = ["application/json", "text/plain"]
      request.body = payload.to_json
      response = https.request(request)

      JSON.parse(response.read_body, { symbolize_names: true })
    end

    def track(courier, tracking_no)
      rest_api('/find', payload_with_courier_and_tracking_no(courier, tracking_no))
    end

    def dhl_express(tracking_no)
      rest_api('/dhl-express', payload_tracking_no(tracking_no))
    end

    def flash_express(tracking_no)
      rest_api('/flash-express', payload_tracking_no(tracking_no))
    end

    def jt_express(tracking_no)
      rest_api('/jt-express', payload_tracking_no(tracking_no))
    end

    def kerry_express(tracking_no)
      rest_api('/kerry-express', payload_tracking_no(tracking_no))
    end

    def scg_express(tracking_no)
      rest_api('/scg-express', payload_tracking_no(tracking_no))
    end

    def shopee_express(tracking_no)
      rest_api('/shopee-express', payload_tracking_no(tracking_no))
    end

    def thailand_post(tracking_no)
      rest_api('/thailand-post', payload_tracking_no(tracking_no))
    end

    def alpha_fast(tracking_no)
      rest_api('/alpha-fast', payload_tracking_no(tracking_no))
    end

    def best_express(tracking_no)
      rest_api('/best-express', payload_tracking_no(tracking_no))
    end

    def cj_logistics(tracking_no)
      rest_api('/cj-logistics', payload_tracking_no(tracking_no))
    end

    def speed_d(tracking_no)
      rest_api('/speed-d', payload_tracking_no(tracking_no))
    end

    def ninja_van(tracking_no)
      rest_api('/ninja-van', payload_tracking_no(tracking_no))
    end

    def nim_express(tracking_no)
      rest_api('/nim-express', payload_tracking_no(tracking_no))
    end

    def bee_express(tracking_no)
      rest_api('/bee-express', payload_tracking_no(tracking_no))
    end

    def inter_express(tracking_no)
      rest_api('/inter-express', payload_tracking_no(tracking_no))
    end

    def tnt_express(tracking_no)
      rest_api('/tnt-express', payload_tracking_no(tracking_no))
    end

    def tp_logistics(tracking_no)
      rest_api('/tp-logistics', payload_tracking_no(tracking_no))
    end

    def ups(tracking_no)
      rest_api('/ups', payload_tracking_no(tracking_no))
    end

    def business_idea_transport(tracking_no)
      rest_api('/business-idea-transport', payload_tracking_no(tracking_no))
    end

    def payload_with_courier_and_tracking_no(courier, tracking_no)
      {
        courier: courier,
        trackingNo: tracking_no
      }
    end

    def payload_tracking_no(tracking_no)
      {
        trackingNo: tracking_no
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
