require_relative "../lib/scraper.rb"
require_relative "../lib/state.rb"
require_relative "../lib/park.rb"



class CommandLineInterface
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm" 
  @@ex_url = "https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644"
  
  
 def run 
   state = state_options
   state_search(state)
   
end

def state_search(state)
  activity = activity_options(state)
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


def state_options 
  arr = Scraper.states_array

  arr.each_with_index do |hash, index|
    puts "#{index + 1}...#{hash[:name]}"
  end
  
  puts "------------------------------------------------------"
  puts "Please enter the number of the state you'd wish to explore."
  
  #num = gets.chomp.to_i - 1
  
  choice = valid_selection(arr)
  
  state = Scraper.scrape_state(choice)
  
  puts state.name
  
  state

end


def activity_options(state)
  arr = Scraper.scrape_options(state.state_url)
  arr.each_with_index do |act, index|
    puts "#{index + 1}...#{act[:activity]}"
  end
  puts "------------------------------------------------------"
  puts "Please enter the activity you wish to do."
  puts "Or enter 0 to see all the parks in #{state.name}." 

  valid_selection(arr)
end

def valid_selection(arr)
  
   num = arr.length + 1
  until num < arr.length 
   num = gets.chomp.to_i - 1
    puts ""
    if num >= arr.length 
    puts "Sorry, that is not a valid selection. Please try again." 
    else
    return arr[num]
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

  puts "-----------------------"
  puts "Please enter the number of the park you'd wish to explore."
  if search_results.length >= 2 == true
  puts "Or enter 0 to see all listed park's details."
  end
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
  puts "Park Name:            "+choice.name 
  puts "Park location:        "+ choice.location.gsub("PO Box ", "")
  puts "States with access:   " + choice.state_code_list.join(", ") #replace this with state obj list
  choice.all_states
  puts "Park url :            " + choice.url
  puts "Park Phone no.        "+choice.phone
  puts "------------------------------------------------------"
end

def research(state)
  
  puts "What would you like to do next?"
  puts ""
  puts "1...Keep searching this state."
  puts "2...Search a different State."
  puts "3...Exit"
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




#end of class


end
