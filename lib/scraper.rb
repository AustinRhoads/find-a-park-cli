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
    parks_urls = []
    
    doc = Nokogiri::HTML(open(url))
    
    #park names - doc.css('ul h3').each {|x| puts x.text}
    #all park extensions - doc.css('ul h3 a/@href').each
    #example - https://www.nps.gov/alka/index.htm
    #{|x| puts x.text}
    
    doc.css('ul h3 a/@href').each do |href|
    url = "https://www.nps.gov" + href.text + "index.htm"
    parks_urls << url
  end
  binding.pry
     return parks_urls
    
    
  end
  
  
  #end of scraper class
end

#url = 'https://www.nps.gov/findapark/index.htm'

#scrape = Scraper.new (url)