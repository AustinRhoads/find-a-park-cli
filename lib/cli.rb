require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  
  @@states_array = Scraper.scrape_state_names(@@URL)
  
 def run 
   state_options
   
end



def state_options 

@@states_array.each_with_index do |hash, index|
  puts "#{index + 1}...#{hash[:name]}"
 
end
 puts "-----------------------"
  puts "Please enter the number of the state you'd wish to explore."
   num = gets.chomp.to_i - 1
  name = @@states_array[num][:name]
  value = @@states_array[num][:value]
 url = @@URL +"?s=#{value}&p=1&v=0"
 hash = {}
 hash[:name] = name
 hash[:state_url] = url
 state = State.new(hash)
 
 
 puts state.name
 binding.pry
 state
end













#end of class


end
