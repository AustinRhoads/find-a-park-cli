require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  
  #@@states_array = Scraper.scrape_state_names(@@URL)
  
 def run 
   state = state_options
   activity = activity_options(state)
   ex_url = "https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644"
   Scraper.experiment(ex_url, state, activity)
   
end



def state_options 
  arr = Scraper.states_array

arr.each_with_index do |hash, index|
  puts "#{index + 1}...#{hash[:name]}"
 
end
 puts "-----------------------"
  puts "Please enter the number of the state you'd wish to explore."
   num = gets.chomp.to_i - 1
   state = Scraper.scrape_state(num)

 
 
 puts state.name
 
 state
end


def activity_options(state)
  arr = Scraper.scrape_options(state.state_url)
  arr.each_with_index do |act, index|
    puts "#{index + 1}...#{act[:activity]}"
  end
  puts "-----------------------"
  puts "Please enter the activity you wish to do."
  num = gets.chomp.to_i - 1
  return arr[num]
  
end



#park list- doc.css('div select optgroup').text
#park-list - doc.css('#alphacode').text 
#park-list - doc.css('.js-multiselect-findapark').text






#end of class


end
