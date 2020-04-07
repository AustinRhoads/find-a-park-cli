require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  @@BASE_PATH = "https://www.nps.gov"
  
  def self.scrape_states(url)
    
   # arr = []
    
  #  doc = Nokogiri::HTML(open(url))
  
  #  doc.css('map area').each do |state|
  #    next if state.css('/@alt') == "shape"
   #   hash = {}
  #    hash[:name] = state.css('/@alt').text
   #   hash[:state_url] = @@BASE_PATH + state.css('/@href').text 
  #    arr << hash
   # end
      
   
  # return arr
   
   #end of scrape_states
  end
  
  
  def self.park_urls(url)
   # arr = []
    
    #doc = Nokogiri::HTML(open(url))
    
    #doc.css('ul h3 a/@href').each do |href|
    #url = @@BASE_PATH + href.text + "index.htm"
    #arr << url
  end
     return arr
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
  
  
  #end of scraper class
end

