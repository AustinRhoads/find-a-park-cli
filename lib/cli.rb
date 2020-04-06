require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
 def self.run 
   
url = 'https://www.nps.gov/findapark/index.htm'
states_array = Scraper.scrape_states(url)
State.make_from_collection(states_array)
states_names = []
State.all.each {|x| states_names << x.name}

State.all.each{|state| Scraper.scrape_parks(state.stae_url)}
#binding.pry

end

#end of class
end
