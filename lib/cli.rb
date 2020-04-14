require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  
  #@@states_array = Scraper.scrape_state_names(@@URL)
  
 def run 
   choice = state_options
   activity_options(choice)
   Scraper.experiment#("https://www.nps.gov/findapark/advanced-search.htm?s=CA&a=3&a=3,23&p=1&v=0")
   
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
  
end



#park list- doc.css('div select optgroup').text
#park-list - doc.css('#alphacode').text 
#park-list - doc.css('.js-multiselect-findapark').text






#end of class


end
