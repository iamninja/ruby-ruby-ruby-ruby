require "rubygems"
require "nokogiri"
require "open-uri"
require "fileutils"

BASE_URL = "http://catalog.data.gov"
BASE_DIR = "/dataset?page="
LOCAL_DIR = "data/datagov-pages"

FileUtils.makedirs(LOCAL_DIR) unless File.exists?LOCAL_DIR

page = Nokogiri::HTML(open(BASE_URL + BASE_DIR + "1"))
File.open("#{LOCAL_DIR}/1.html", "w"){ |f| f.write(page.to_html) }

last_page_number = page.css("div.pagination ul li a")[-2].text.to_i
puts "There are #{last_page_number} in total"
puts "Page 1 already fetched"

puts "Iterating from page 2 to #{last_page_number}"
for page_number in 2..last_page_number do
	puts "Getting page #{page_number}"
	File.open("#{LOCAL_DIR}/#{page_number}.html", 'w') do |f|
		f.write(open("#{BASE_URL}#{BASE_DIR}#{page_number}").read)
	end
end