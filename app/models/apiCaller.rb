require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class ApiCaller
    def self.api_request(link)
        response = HTTParty.get(link)
        response.parsed_response
    end

    def self.external_api_request(link, api_host, end_point)
        url = URI(link + end_point)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = api_host
        request["x-rapidapi-key"] = ENV['APIKEY']

        response = http.request(request)
        JSON.parse(response.body)
    end
end