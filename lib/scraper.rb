require 'pry'
require 'nokogiri'

class Scraper
  
  def intitialize(url)
    
    doc = Nokogir::HTML(open(url))
    binding.pry
  end
  
end
