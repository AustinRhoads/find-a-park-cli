
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm"
  
 # @@state_options = Scraper.scrape_state_names(@@URL)
  
 
 
 
  def self.scrape_state_names(url)
    
    arr = []
   
   doc = Nokogiri::HTML(open(url))
  
 # binding.pry 
  doc.css('select#form-park option').each do |state_name|
    
    next if state_name.text == "State"
    hash = {}
    hash[:name] = state_name.text
    hash[:value] = state_name.css('/@value').text
    arr << hash
  end
  
  return arr
  
  
   #end of scrape_states
    end
  
  
  def self.park_urls(url)
   # arr = []
    
    #doc = Nokogiri::HTML(open(url))
    
    #doc.css('ul h3 a/@href').each do |href|
    #url = @@BASE_PATH + href.text + "index.htm"
    #arr << url
 # end
    # return arr
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
  
  
  
  def self.scrape_park(url)
  #  arr = []
   # doc = Nokogiri::HTML(open(url))
    #park name - doc.css('a.Hero-title').text
    #park mailing location -  doc.css("p.adr").text.tr("\n", "")
    #park phone - doc.css('span.tel').text.tr("\n", "")
    #basic info url - @@BASE_PATH + doc.css('.UtilityNav a/@href').first.text
    #basic_info_url = @@BASE_PATH + doc.css('.UtilityNav a/@href').first.text
  #  i_doc = Nokogiri::HTML(open(basic_info_url))
   # binding.pry
    
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
   
     #big_book[0][0].delete("STATE_NAME:") == "Kentucky"
   
    big_book.each do |x|
      x.each do |b|
        if b.include?(state.name)
           x 
        end
      end 
    end

    binding.pry
  end
  

  

  
  
  #end of scraper class
end


#inlinescript = doc.xpath('//script[not(@src)]').text
#new_doc = Nokogiri::HTML(open('https://www.nps.gov/findapark/find_a_park.json?dt=1586816373644'))
