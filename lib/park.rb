class Park
  @@all = []
  attr_accessor :name, :state, :url, :location, :phone
  
  def initialize(name, state)
    @state_code_list = []
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

def state_code_list 
 @state_code_list 
end

  
end