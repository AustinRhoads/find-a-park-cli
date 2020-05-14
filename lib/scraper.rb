
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
  
  
  def self.scrape_state(choice)
    
  
    url = @@URL +"?s=#{choice[:value]}&p=1&v=1"
    hash = {}
    hash[:name] = choice[:name]
    hash[:state_url] = url
    hash[:state_code] = choice[:value]
    state = State.new(hash)
    return state
  end
  
  
  def self.scrape_activity_options(url)
    
    doc = Nokogiri::HTML(open(url))
       
    activity_arr = []
    
    doc.css('select#form-activity option').each do |activity|
      hash = {}
      hash[:activity] = activity.text 
      hash[:value] = activity.css('/@value').text
      activity_arr << hash 
    end
    
    activity_arr.push({:activity => "all parks", :value => "00"})
    
    return activity_arr
    
  end
  
  
  
  def self.states_array 
    Scraper.scrape_state_names(@@URL)
  end
  
  def self.search_parks(url, state, activity)
    
    doc = Nokogiri::HTML(open(url))
    
    fulltext = doc.text 
    
    data_array = fulltext.split(/(?=STATE_NAME)/)
    
    data_array.shift
    
    big_book = []
   
     data_array.each do |park_data|
      state_code_list = park_data.gsub(/\"|{|}/, "").split("STATE_CODE_LIST:").pop.split("BANNER")[0].gsub(" ","").split(",")
      park_page = park_data.gsub(/\"|{|}/, "").split(/,/)
      complete_page = park_page << state_code_list 
      big_book << complete_page
      
      end
   
     search_array = []
   
     big_book.each do |x|
      
      x.each_with_index do |b, index|
        
        if x.last.include?(state.state_code)
            search_array << x
       end
      end 
      
    end
    
Scraper.make_parks(search_array, state)
  
  end
  
def self.make_parks(arr, state)
 
arr.each do |x|
 
  name = ""
  activity_codes = []
  park_code = ""
  state_code_list = x.last
  x.each do |b|
    if b.include?("PARK_NAME")
      name = b.gsub("PARK_NAME:", "")
    elsif b.include?("activity_id:") 
    activity_codes << b.gsub(/\D/, "")
    elsif b.include?("PARK_CODE")
    park_code = b.gsub("PARK_CODE:", "")
    end
  end
  next if Park.all_urls.include?(@@BASE_PATH + "/" + park_code + "/" + @@SUFFIX)
   park = Park.new(name, state_code_list)
   activity_codes.each {|a| park.activity_codes << a} 
   park.activity_codes << "00"
   park.url = @@BASE_PATH + "/" + park_code + "/" + @@SUFFIX
   Scraper.add_details(park)
end

end  

def self.add_details(choice)
 
  if choice.location == nil
  doc = Nokogiri::HTML(open(choice.url))
  choice.location = doc.css("p.adr span[itemprop='addressLocality']").text + " " + doc.css("p.adr span[itemprop='addressRegion']").text + " " + doc.css("p.adr span[itemprop='postalCode']").text
  choice.phone = doc.css('span.tel').text.gsub(/\n/, "")
  end
end


def self.find_in_states_array(code)
  
  arr = CommandLineInterface.state_options
  arr.each do |hash|
    if hash[:value] == code 
      return hash 
    end
    end
  
end
  
  
  #end of scraper class
end



