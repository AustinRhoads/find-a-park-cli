require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
 def self.run 
   
   BASE_PATH = "https://www.nps.gov"
   
url = BASE_PATH + '/findapark/index.htm'
states_array = Scraper.scrape_states(url)
State.make_from_collection(states_array)
states_names = []
State.all.each {|x| states_names << x.name}

urls = Scraper.park_urls(State.all.first.state_url)
Scraper.scrape_park(urls[1])

end

#end of class
end
