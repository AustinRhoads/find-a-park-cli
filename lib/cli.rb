require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm"
  
 def self.run 
   puts "hey"
end



def options 


states_array = Scraper.scrape_states(@@URL)

end










#end of class


end
