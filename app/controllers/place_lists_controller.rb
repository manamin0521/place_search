class PlaceListsController < ApplicationController
  def index
    @place = PlaceList.new

    API_KEY = 'AIzaSyDEhtQbIdDR_5KQjMBgIPSoEb2IELXYTG0'
      lat = '-33.8670522'
      lng = '151.1957362'
      rad = '5000'

      types = 'hospital'

      language = 'en'

      uri = URI.parse "https://maps.googleapis.com/maps/api/place/radarsearch/json?location=#{lat},#{lng}&radius=#{rad}&types=#{types}&language=en&key=#{API_KEY}"

      request = Net::HTTP::Get.new(uri.request_uri)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end

      body = JSON.parse response.body
      results = body['results']

      results.each do |result|
        place_id = result['place_id']

        uri2 = URI.parse "https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&language=en&key=#{API_KEY}"

        request = Net::HTTP::Get.new(uri2.request_uri)
        response = Net::HTTP.start(uri2.host, uri2.port, use_ssl: uri2.scheme == 'https') do |http|
          http.request(request)
        end

        detail = JSON.parse response.body
        place_detail = detail['result']

        location = place_detail['geometry']['location']
        answer = {lat: location['lat'], lng:location['lng'], name:place_detail['name']}

        File.open('./place.json', 'a') do |file|
            file.puts JSON.pretty_generate(answer)
        end
      end
  end
end
