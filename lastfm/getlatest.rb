require 'rubygems'
require 'json'
require 'net/http'
require './key-and-secret.rb'

# Make a request
def make_response(user, method)
	base_url = "http://ws.audioscrobbler.com/2.0"
	address = URI("#{base_url}/?method=#{method}&user=#{user}&api_key=#{API_KEY}&format=json")

	#HTTP
	http = Net::HTTP.new address.host, address.port

	#Make the request
	request = Net::HTTP::Get.new address.request_uri
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
	JSON.parse(response.body)

end

# Return the most recent songs
def latest_tracks(user, method)

	# Get the tweets
	response = make_response(user, method)
	recenttracks = JSON.parse(response.body)['recenttracks']
	recenttracks['track']
end

# Print songs
def print_tracks(tracks)

	# Itterate through songs
	tracks.each do |track|
		puts track['artist']['#text']
		puts track['name'] + " - " + track['album']['#text']
		puts ""
	end
end

# Print the latest song
def print_latest_song(tracks)
	
	puts tracks[0]['artist']['#text']
	puts tracks[0]['name'] + " - " + tracks[0]['album']['#text']
end

# Set the user
user = "zangetsu234"

# Get latest tracks
method = "user.getrecenttracks"
tracks = latest_tracks(user, method)
print_tracks(tracks)
puts "- " * 15
print_latest_song(tracks)