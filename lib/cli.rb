require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm"
  
 def run 
   state_options
end



def state_options 
states_array = Scraper.scrape_states_names(@@URL)
states_array.each_with_index do |name, index|
  puts "#{index + 1}...#{name}"
end

end










#end of class


end
