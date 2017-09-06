require 'net/https'
require 'uri'
require 'json'

API_KEY = 'AIzaSyDEhtQbIdDR_5KQjMBgIPSoEb2IELXYTG0'
lat = '-33.8670522'
lng = '151.1957362'
rad = '5000'

#types = 'restaurant'
types = 'university'
#types = 'hospital'
#types = 'school'

language = 'en'

uri = URI.parse "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{rad}&types=#{types}&language=en&key=#{API_KEY}"

request = Net::HTTP::Get.new(uri.request_uri)
response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
  http.request(request)
end

body = JSON.parse response.body
results = body['results']

p "types - #{types}"

results.each do |place|
  location = place['geometry']['location']
  # lat, lng = location['lat'], location['lng']
  
  p "#{location['lat']}, #{location['lng']}, #{place['name']}"
end
