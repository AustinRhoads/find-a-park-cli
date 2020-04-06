require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"




url = 'https://www.nps.gov/findapark/index.htm'
states_array = Scraper.scrape_states(url)
State.make_from_collection(states_array)
binding.pry
