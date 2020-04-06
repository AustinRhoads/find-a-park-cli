require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  def initialize(url=nil)
    
    doc = Nokogiri::HTML(open(url).read)
    binding.pry
  end
  
end

url = 'https://www.nps.gov/findapark/index.html'

scrape = Scraper.new(url)