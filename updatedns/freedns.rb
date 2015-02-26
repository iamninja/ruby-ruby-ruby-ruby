require 'digest/sha1'
require 'open-uri'
require 'rexml/document'

# Credentials
username = ""
password = ""

# Generate SHA key
hash_key = Digest::SHA1.hexdigest "#{username}|#{password}"
puts hash_key
puts "#{username}|#{password}"

# Make request
open("http://freedns.afraid.org/api/?action=getdyndns&sha=#{hash_key}&style=xml") do |r|
	puts "Status: #{r.status[0]}, #{r.status[1]}."
	xmlresp = REXML::Document.new(r.read)
	host = xmlresp.elements['xml/item/host'].text
	address = xmlresp.elements['xml/item/address'].text
	puts "#{address} setted on #{host}."
end



