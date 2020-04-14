class Park
  @@all = []
  attr_accessor :name, :state, :url
  
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

  
end