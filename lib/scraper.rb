require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def self.scrape_states(url)
    arr = []
    doc = Nokogiri::HTML(open(url))
    #states names - doc.css('form option').each {|x| puts x.text}
    #states name from map -  doc.css('map area/@alt').each   #{|x| puts x.text}
     #states url - doc.css('map area/@href').each {|x| puts url + x.text}
      #states url - doc.css('map area/@href').each {|x| puts url + x.text}
      hash = {}

    doc.css('map area').each do |state|
      hash[:name] = state.css(/@alt).text
      hash[:state_url] = state.css(/@href).text 
      arr << hash
    end
      
    binding.pry
  end
  
end

#url = 'https://www.nps.gov/findapark/index.htm'

#scrape = Scraper.new (url)