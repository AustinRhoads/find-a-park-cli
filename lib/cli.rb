require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"




url = 'https://www.nps.gov/findapark/index.htm'
scrape = Scraper.scrape_states(url)