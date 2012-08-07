require 'net/http'
require 'json'

module SmsPilot

  class << self
    def new(api_key)
      Client.new(api_key)
    end
  end

  class Client

    API_URI = 'http://smspilot.ru/api2.php'

    def initialize(api_key)
      raise ArgumentError, "api key must be defined" if api_key.nil?
      @api_key = api_key
    end

    def sms(*args)
      if args[0].is_a?(String) && args[1].is_a?(String)
        messages =[ {text: args[0], to: args[1], from: args[2], id: args[3]} ]
      elsif args.first.is_a?(Hash)
        messages = [args.first]
      elsif args.first.is_a?(Array)
        messages = args.first
      else
        raise ArgumentError,
              'Usage: sms(text, to, from = nil, id = nil) OR sms(message_as_hash) OR sms(array_of_messages)'
      end
      request({send: messages})
    end

    def check(*ids)
      request({check: ids.map{ |id| {server_id: id} }})
    end

    def check_packet(packet_id)
      request({check: true, server_packet_id: packet_id})
    end

    def balance
      request({balance: true})
    end

    def user_info
      request({info: true})
    end

    def inbound
      request({inbound: true})
    end

    private

    def request(data)
      data['apikey'] = @api_key
      uri = URI.parse(API_URI)
      request = Net::HTTP::Post.new(uri.request_uri,
                                    initheader = {'Content-Type' =>'application/json'})
      request.body = data.to_json
      response = Net::HTTP.new(uri.host, uri.port).request(request)
      JSON.parse(response.body)
    end
  end
end
