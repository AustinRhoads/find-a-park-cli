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
  
  def self.scrape_parks(url)
    
    doc = Nokogiri::HTML(open(url))
    
    binding.pry
    
  end
  
  
  #end of scraper class
end

#url = 'https://www.nps.gov/findapark/index.htm'

#scrape = Scraper.new (url)