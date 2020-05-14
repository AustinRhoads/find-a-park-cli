require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"
require "colorize"


class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  @@ex_url = "https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644"
  @@activity_options = []
  @@state_options = []
  
 def run 
   make_activity_list(@@URL)
   make_states_array
   state = state_options_menu
   state_search(state)
   
end

def state_search(state)
  activity = activity_options_menu(state)
  Scraper.search_parks(@@ex_url, state, activity)
  search_results = results(state, activity)
  display_results(search_results, state, activity)
    if search_results.length >=1
   choice = select_a_park(search_results)
   research(state)
 else 
   research(state)
 end
end


def state_options_menu 
 
 arr = @@state_options

  arr.each_with_index do |hash, index|
    puts "#{index + 1}...#{hash[:name].light_cyan}"
  end
  
  puts "------------------------------------------------------"
  puts "Please enter the number of the state you'd wish to explore."
  
  num = valid_selection(arr)
  
  choice = arr[num]
  
  state = State.find_or_make_new(choice)
  puts state.name.green.bold
  
  state

end


def activity_options_menu(state)
  
  arr = @@activity_options
  arr.each_with_index do |act, index|
    puts "#{index + 1}...#{act[:activity].light_cyan}"
  end
  puts "------------------------------------------------------"
  puts "Please enter the number of the activity you wish to do."
  puts "Or enter " + "0".green.bold + " to see all the parks in #{state.name.green.bold}." 

  num = valid_selection(arr)
  arr[num]
end

def valid_selection(arr)
  
   num = arr.length + 1
  until num < arr.length 
   num = gets.chomp.to_i - 1
    puts ""
    puts "Loading details..."
#binding.pry
    if num >= arr.length 
    puts "Sorry, that is not a valid selection. Please try again.".light_red 
    else
   return num
  end
  end
  
end


def results(state, activity)
  
  arr = []

  state.parks.each do |park|
    if park.activities.include?(activity[:value])
      arr << park 
    end
  end 
  return arr
end

def select_a_park(search_results)

  puts "------------------------------------------------------"
  puts "Please enter the number of the park you'd wish to explore."
  if search_results.length >= 2 == true
  puts "Or enter " + "0".green.bold + " to see all listed park's details."
  end
  num = gets.chomp.to_i - 1
  if num == -1
    search_results.each do |p|
      more_details(p)
      display_choice(p)
    end
  else
  choice = search_results[num]
 # more_details(choice)
  display_choice(choice)
  end
  return choice

end


def display_results(search_results, state, activity)
    if search_results.length == 1 
    puts "#{search_results.length}".green.bold + " result found for #{activity[:activity].green.bold} in #{state.name.green.bold}"
   else
    puts "#{search_results.length}".green.bold + " results found for #{activity[:activity].green.bold} in #{state.name.green.bold}"
   end
     search_results.each_with_index do |park, index|
     puts "#{index + 1}...#{park.name.light_cyan}"
   end
end

def more_details(choice)
  Scraper.add_details(choice)

end

def display_choice(choice)
  Park.all_urls
  puts ""
  puts ""
  puts ""
  puts "Park Name:            ".green.bold + choice.name.green.bold
  #puts "All activities:       ".light_cyan + available_activities(choice).join(", ").light_cyan
  puts "Park location:        ".light_cyan + choice.location.gsub("PO Box ", "").light_cyan
  puts "States with access:   ".light_cyan + choice.state_code_list.join(", ").light_cyan 
  puts "Park url :            ".light_cyan + choice.url.light_cyan
  puts "Park Phone no.        ".light_cyan + choice.phone.light_cyan
  puts "------------------------------------------------------"
end

def research(state)
  
  puts "What would you like to do next?"
  puts ""
  puts "1..." + "Keep searching this state.".light_cyan
  puts "2..." + "Search a different State.".light_cyan
  puts "3..." + "Exit".light_red
  next_action = gets.chomp
  case next_action 
  when "1"
    state_search(state)
  when "2" 
      run
  else 
    puts "Thanks for using the Find-a-Park cli app!"
  end

end

def make_activity_list(url)
  if @@activity_options == [] 
    @@activity_options = Scraper.scrape_activity_options(url)
  end 
end 

def make_states_array 
  if @@state_options == []
    @@state_options = Scraper.states_array
  end 
end

#def available_activities(park)
 # arr = []
  #park.activities.each do |code|
   # next if code == "00"
    #activity = return_activity_name_from_code(code)
    #arr << activity
  #end
  
  #return arr
#end 

#def return_activity_name_from_code(code)
 # activity_name = ""
#  @@activity_options.each do |hash|
 #   if hash[:value] == code 
  #    activity_name = hash[:activity]
  #  end
#  end
#  return activity_name
#end

#end of class


end
