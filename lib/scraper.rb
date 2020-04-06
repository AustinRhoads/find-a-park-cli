require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def initialize(url)
    
    doc = Nokogiri::HTML(open(url))
    #binding.pry
  end
  
end

url = 'https://www.nps.gov/findapark/index.htm'

scrape = Scraper.new (url)