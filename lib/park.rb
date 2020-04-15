class Park
  @@all = []
  attr_accessor :name, :state, :url, :address, :phone
  
  def initialize(name, state)
    @name = name 
    state.parks << self 
    self.state = state
    @activities = []
    @@all << self
    
  end
  
  def activities
    @activities
  end

def self.all 
  @@all 
end

def self.all_names 
  arr = [] 
  @@all.each do |x|
    arr << x.name 
  end
  return arr
end

  
end