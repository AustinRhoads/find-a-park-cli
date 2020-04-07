require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  
  def self.scrape_states(url)
    
    arr = []
    
    doc = Nokogiri::HTML(open(url))
  
    doc.css('map area').each do |state|
      next if state.css('/@alt') == "shape"
      hash = {}
      hash[:name] = state.css('/@alt').text
      hash[:state_url] = "https://www.nps.gov" + state.css('/@href').text 
      arr << hash
    end
      
   
   return arr
   
   #end of scrape_states
  end
  
  
  def self.park_urls(url)
    arr = []
    
    doc = Nokogiri::HTML(open(url))
    
    doc.css('ul h3 a/@href').each do |href|
    url = "https://www.nps.gov" + href.text + "index.htm"
    arr << url
  end
     return arr
  end
  
  def self.scrape_park(url)
    arr = []
    doc = Nokogiri::HTML(open(url))
    #park name - doc.css('a.Hero-title').text
    #park location -  doc.css("p.adr").text.tr("\n", "")
    #park phone - doc.css('span.tel').text.tr("\n", "")
    binding.pry
    
  end
  
  
  #end of scraper class
end

