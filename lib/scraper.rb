
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  @@URL = "https://www.nps.gov/findapark/advanced-search.htm"
  
  @@state_options = Scraper.scrape_state_names(@@URL)
  
 
 
 
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
  
  def self.scrape_state(name, url)
    doc = Nokogiri::HTML(open(url))
    binding.pry
    
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
  
  def self.state_options 
    @@state_options
  end
  
  
  #end of scraper class
end

