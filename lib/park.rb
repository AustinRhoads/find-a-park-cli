class Park
  @@all
  attr_accessor :park_name, :state_name, :url
  
  def initialize(hash)
    
    @activities = []
    @@all << self
  end
  
  

  
end