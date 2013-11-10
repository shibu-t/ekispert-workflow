require 'net/http';
require 'uri'
require 'json'
require './Endpoint'

class Station

    def initialize(name)
        @name = name
    end

    def getUrl
        station_url = Endpoint.getStationUrl
        url = station_url + @name
        return url
    end

    def getUri(url)
        url_escape = URI.escape(url)
        uri = URI(url_escape)
        return uri
    end

    def getResponse
        url = getUrl
        uri = getUri(url)
        body = Net::HTTP.get_response(uri).body;
        json = JSON.parse(body);
        return json
    end

end
