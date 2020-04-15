require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  @@ex_url = "https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644"
  #@@states_array = Scraper.scrape_state_names(@@URL)
  
 def run 
   state = state_options
   activity = activity_options(state)
   
   Scraper.experiment(@@ex_url, state, activity)
   search_results = results(state, activity)
   if search_results.length == 1 
   puts "#{search_results.length} result found for #{activity[:activity]} in #{state.name}"
 else
   puts "#{search_results.length} results found for #{activity[:activity]} in #{state.name}"
 end
   search_results.each_with_index do |park, index|
     puts "#{index + 1}...#{park.name}"
   end
   binding.pry
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


def results(state, activity)
  arr = []
  Park.all.each do |park|
    if park.state == state && park.activities.include?(activity[:value])
      arr << park 
    end
  end 
  return arr
end


#park list- doc.css('div select optgroup').text
#park-list - doc.css('#alphacode').text 
#park-list - doc.css('.js-multiselect-findapark').text






#end of class


end
