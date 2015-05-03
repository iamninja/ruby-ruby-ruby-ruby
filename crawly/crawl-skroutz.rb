require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'fileutils'

HEADER_HASH	= { 'User-Agent' => 'Ruby/#{RUBY_VERSION}' }

url_list = Array.new
# Read links from file
File.open("skroutz-product-list.txt", "r").each do |line|
	url_list.push(URI.parse(URI.encode(line.strip)))
end

url_list.each do |url|
	print "Fetching data..."
	page = Nokogiri::HTML(open(url, HEADER_HASH))
	product_name = page.css('title').text.slice(/.+?(?=\|)/).strip
	lowest_price = page.css('a.price_link')[0].text

	print "\r"
	print "#{product_name}: #{lowest_price}\n"
end

