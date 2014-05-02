require 'rubygems'
require 'oauth'
require 'json'
require './keys-and-tokens.rb'

# Make a response
def make_response(arg1,arg2)
  base_url = "https://api.twitter.com"
  address = URI("#{base_url}/1.1/#{arg1}/#{arg2}.json")

  #HTTP
  http             = Net::HTTP.new address.host, address.port
  http.use_ssl     = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #Set keys and tokens
  consumer_key = OAuth::Consumer.new API_KEY, API_SECRET
  access_token = OAuth::Token.new ACCESS_TOKEN, ACCESS_TOKEN_SECRET

  #Make the request
  request = Net::HTTP::Get.new address.request_uri
  request.oauth! http, consumer_key, access_token
  http.start
  response = http.request(request)

  if response.code == '200'
    puts "No problem!! Starting..."
    return response
  else
    puts "Expected a response of 200 but got #{response.code}"
  end

end

# Parse a response from the API and return a user object.
def parse_user_response(response)

  user = JSON.parse(response.body)

end

# Return k-latest tweets (default 5)
def latest_tweets(k=5)

  # Get the tweets
  response = make_response("statuses","user_timeline")
  timeline = JSON.parse(response.body)
  tweets = timeline[0..k-1]

end

def print_timeline(tweets)

  # Itterate through tweets
  tweets.each do |tweet|
     puts tweet["text"]
     puts ""
  end

end

# response = make_response("account","verify_credentials")
# user = parse_user_response(response)

tweets = latest_tweets(0)
print_timeline(tweets)
