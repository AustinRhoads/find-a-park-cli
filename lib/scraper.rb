
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm"
  @@BASE_PATH = "https://www.nps.gov"
  @@SUFFIX = "index.htm"
 
  def self.scrape_state_names(url)
    
    arr = []
   
    doc = Nokogiri::HTML(open(url))
   
    doc.css('select#form-park option').each do |state_name|
    
    next if state_name.text == "State"
    hash = {}
    hash[:name] = state_name.text
    hash[:value] = state_name.css('/@value').text
    arr << hash
  end
  
  return arr
  
  
   #end of scrape_states_names
    end
  

  
  def self.scrape_state(num)
    arr = Scraper.states_array
    name = arr[num][:name]
    value = arr[num][:value]
    url = @@URL +"?s=#{value}&p=1&v=1"
    hash = {}
    hash[:name] = name
    hash[:state_url] = url
     state = State.new(hash)
     
    
    return state
  end
  
  def self.scrape_options(url)
    
       doc = Nokogiri::HTML(open(url), nil, 'utf-8')
       
    activity_arr = []
    
    doc.css('select#form-activity option').each do |activity|
    hash = {}
    hash[:activity] = activity.text 
    hash[:value] = activity.css('/@value').text
    activity_arr << hash 
  end
  return activity_arr
    
  end
  
  
  
  def self.states_array 
    Scraper.scrape_state_names(@@URL)
  end
  
  def self.experiment(url, state, activity)
    
    doc = Nokogiri::HTML(open(url))
    
    fulltext = doc.text 
    
    data_array = fulltext.split(/(?=STATE_NAME)/)
    
    data_array.shift
    
    big_book = []
     data_array.each do |park_data|
     big_book << park_data.gsub(/\"|{|}/, "").split(/,/)
   end
   
     
     search_array = []
   
    big_book.each do |x|
      x.each do |b|
        if b.include?(state.name)
            search_array << x
        end
      end 
    end
    
Scraper.make_parks(search_array, state)
  #binding.pry
  end
  
def self.make_parks(arr, state)
arr.each do |x|
  name = ""
  park_state = state
  activities = []
  park_code = ""
  x.each do |b|
    if b.include?("PARK_NAME")
      name = b.gsub("PARK_NAME:", "")
    elsif b.include?("activity_id:") 
    activities << b.gsub(/\D/, "")
    elsif b.include?("PARK_CODE")
    park_code = b.gsub("PARK_CODE:", "")
    end
  end
   park = Park.new(name, park_state)
   activities.each {|a| park.activities << a} 
   park.url = @@BASE_PATH + "/" + park_code + "/" + @@SUFFIX
end
#binding.pry
end  

  
  
  #end of scraper class
end


#park url - https://www.nps.gov/alca/index.htm
#new_doc = Nokogiri::HTML(open('https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644'))
