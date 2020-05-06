class Park
  @@all = []
  attr_accessor :name, :state, :url, :location, :phone
  attr_reader :state_code_list
  
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

def state_code_list=(list) 
 @state_code_list = list 

end

def all_states
  
  list = self.state_code_list
  arr = list.each {|code| Scraper.find_in_states_array(code)}
  #binding.pry
  
end
  
end