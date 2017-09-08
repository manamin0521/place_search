require 'net/https'
require 'uri'
require 'json'

# API_KEY = 'AIzaSyDEhtQbIdDR_5KQjMBgIPSoEb2IELXYTG0'
API_KEY = 'AIzaSyDVUuLJdMwQA_WPJRAJM2ngyKrUK4r_ROw'
# API_KEY = 'AIzaSyDRK0rZvGzZ2lvu-jW3A3TAExcuEnE5wiU'
# API_KEY = 'AIzaSyB379FMFKJO5sx58uIVkuAfl6SE9ie08gA'

lat = '3.1528496'
lng = '101.7015546'
rad = '50000'

# types = 'train_station'
# types = 'university'
types = 'school'
# types = 'shopping_mall'
# types = 'hospital'

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
  answer = {name:place_detail['name'], lat: location['lat'], lng:location['lng'], types:place_detail['types'], address:place_detail['formatted_address']}

  File.open('./place.json', 'a') do |file|
      file.puts JSON.pretty_generate(answer)
  end
end