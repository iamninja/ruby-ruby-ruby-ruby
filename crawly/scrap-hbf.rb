require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'mongo'

HEADER_HASH = { 'User-Agent' => 'Ruby/#{RUBY_VERSION}' }

mongo_client = Mongo::MongoClient.new('localhost', 27017)
db = mongo_client.db('bridgescoreapi')
playersCollection = db.collection('players')

def get_players_from_pages(page, databaseCollection)
  player = {}
  points = {}
  rows = page.css('table#qres tbody tr')
  rows.each do |row|
    cells = row.css('td')
    player['_id'] = cells[1].text().strip()
    player['name'] = cells[2].text().strip()
    player['club'] = cells[3].text().strip()
    player['category'] = cells[4].text().strip().to_i

    points['black'] = cells[5].text().strip().gsub('.', '').gsub(',', '.').to_i
    points['gold'] = cells[6].text().strip().gsub('.', '').gsub(',', '.').to_i
    points['platimun'] = cells[7].text().strip().gsub('.', '').gsub(',', '.').to_f

    player['points'] = points
    # puts player
    databaseCollection.insert(player)
    # playersCollection.update({'_id' => player['_id']}, player)
  end
end

def next_page(page)
  if (page.css('table.hbfnoborder')[1].css('td')[2].text() === '>>')
    return true
  else
    return false
  end
end

category = 16
url = 'http://www.hellasbridge.org/athlites/category/'

while category > 0
  page_number = 0
  has_next_page = true
  while has_next_page
    page = Nokogiri::HTML(open(url + category.to_s + '/' + page_number.to_s, HEADER_HASH))
    get_players_from_pages(page, playersCollection)
    has_next_page = next_page(page)
    page_number += 1
  end
  puts 'Finished category ' + category.to_s + ', page ' + page_number.to_s
  category -= 1
end
# page = Nokogiri::HTML(open(url, HEADER_HASH))
# get_players_from_pages(page)
# puts next_page(page)
