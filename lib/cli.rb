require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  @@ex_url = "https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644"
  
  
 def run 
   state = state_options
   activity = activity_options(state)
   
   Scraper.search_parks(@@ex_url, state, activity)
   search_results = results(state, activity)
  display_results(search_results, state, activity)
   choice = select_a_park(search_results)

  # binding.pry
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
  puts "Please enter the activity you wish to do, or enter 0 to see all the parks in #{state.name}."
  num = gets.chomp.to_i - 1
  puts ""
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

def select_a_park(search_results)
puts "-----------------------"
puts "Please enter the number of the park you'd wish to explore, or enter 0 to see each park's details."
num = gets.chomp.to_i - 1
if num == -1
  search_results.each do |p|
    more_details(p)
    display_choice(p)
  end
else
choice = search_results[num]
more_details(choice)
display_choice(choice)
 end
return choice
end


def display_results(search_results, state, activity)
    if search_results.length == 1 
   puts "#{search_results.length} result found for #{activity[:activity]} in #{state.name}"
 else
   puts "#{search_results.length} results found for #{activity[:activity]} in #{state.name}"
 end
   search_results.each_with_index do |park, index|
     puts "#{index + 1}...#{park.name}"
   end
end

def more_details(choice)
  Scraper.add_details(choice)

end

def display_choice(choice) 
  puts "Park Name:       "+choice.name 
  puts "Park location:   "+ choice.location.gsub("PO Box ", "")
  puts "Park url :       " + choice.url
  puts "Park Phone no.   "+choice.phone
  puts "------------------------------------------------------"
end

#park list- doc.css('div select optgroup').text
#park-list - doc.css('#alphacode').text 
#park-list - doc.css('.js-multiselect-findapark').text






#end of class


end
