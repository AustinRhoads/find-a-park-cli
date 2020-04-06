require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def self.scrape_states(url)
    arr = []
    doc = Nokogiri::HTML(open(url))
  
      

    doc.css('map area').each do |state|
      hash = {}
      hash[:name] = state.css('/@alt').text
      hash[:state_url] = url + state.css('/@href').text 
      arr << hash
    end
      
    binding.pry
  end
  
end

#url = 'https://www.nps.gov/findapark/index.htm'

#scrape = Scraper.new (url)