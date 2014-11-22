require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"
page = Nokogiri::HTML(open(PAGE_URL))

puts page.css('title')
puts page.css('li')[0].text
puts page.css('li a')[2]['href']
puts page.css("li a[data-category='news']")

# puts page.css('#funstuff')

# puts page.css('div#references a')

links = page.css('a')
puts links.length
puts links[1].text
puts links[1]['href']

news_links = page.css('a').select { |link| link['data-category'] == 'news' }
puts news_links.class
news_links.each{ |link| puts link['href'] }

news_links_nodeset = page.css('a[data-category=news]')
puts news_links_nodeset.class
news_links_nodeset.each{ |link| puts link['href'] }

# Exercise 1
puts("\n#{'-'*15}")
exercise1 = page.css('div#references a')
exercise1.each{ |link| puts "#{link.text}, #{link['href']}" }
puts('-'*15)

# Exercise 2
puts("\n#{'-'*15}")
WIKI_URL = "http://en.wikipedia.org/"
TARGET_URL = WIKI_URL + "wiki/HTML"
wikiPageHTML = Nokogiri::HTML(open(TARGET_URL))

labels = wikiPageHTML.css('table.infobox th')
labels.each{ |label| puts label.text }
puts('-'*15)