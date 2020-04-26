class ApiCaller
    def self.api_request(link)
        response = HTTParty.get(link)
        response.parsed_response
    end
end