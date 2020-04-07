require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  
  @@states_array = Scraper.scrape_state_names(@@URL)
  
 def run 
   state_options
   state_finder
end



def state_options 

@@states_array.each_with_index do |hash, index|
  puts "#{index + 1}...#{hash[:name]}"
 
end
 puts "-----------------------"
  puts "Please enter the number of the state you'd wish to explore."

end

def state_finder 
  num = gets.chomp.to_i
  value = @@states_array[num - 1][:value]
 url = @@URL +"?s=#{value}&p=1&v=0"
 Scraper.scrape_state(url)
end










#end of class


end
