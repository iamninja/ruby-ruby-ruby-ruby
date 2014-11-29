require "rubygems"
require "nokogiri"
require "open-uri"
require "fileutils"

DATA_DIR = "data/anthems"
FileUtils.mkdir_p(DATA_DIR) unless File.exists?(DATA_DIR)

BASE_WIKIPEDIA_URL = "http://en.wikipedia.org"
LIST_URL = "http://en.wikipedia.org/wiki/List_of_national_anthems"

HEADER_HASH = {'User-Agent' => "Ruby/#{RUBY_VERSION}"}

page = Nokogiri::HTML(open(LIST_URL, HEADER_HASH))
countriesInRows = page.css('div.mw-content-ltr table.wikitable tr')

<<<<<<< HEAD
=======
# countryNames = Array.new()
# anthemName = Array.new()
# anthemAuthor = Array.new()

>>>>>>> 42e3ca0204b6c6026643f31f005e0a236fbf85d3
# Debbuging
# puts countriesInRows.class
# puts countriesInRows[1].children()
# puts countriesInRows[1].children()[3].text

# Creates a file with links to the wikipedia pages of
# all the national anthems.
# Format: "#{countryName}\t#{link}"
def create_links_list(countriesInRows)
	# Clear the output file
	local_fname = "#{DATA_DIR}/links.txt"
	File.open("./#{local_fname}", 'w+') { |file| 
			file << ""
		}

	countriesInRows.each do |country|
		# Jump to next iteration if the row we picked is not a country row
		# i.e. if the row header is not containing an anchor
		# We check this by looking for an empty anchor
		next if country.css("th a").text == ""

		href = country.css("td a").attr('href')

		File.open("./#{local_fname}", "a") { |file| 
			file.puts country.css("th a").text + "\t" + BASE_WIKIPEDIA_URL + href
		}

	end
end

create_links_list(countriesInRows)