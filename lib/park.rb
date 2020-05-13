class Park
  @@all = []
  attr_accessor :name, :state, :url, :location, :phone
  attr_reader :state_code_list, :all_states
  
  def initialize(name, state_code_list)
    @state_code_list = state_code_list
    @all_states = []
    @name = name 
    @activities = []
    @@all << self
    self.add_all_states
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

def add_all_states 
  
  array_of_hashes = []
  list = self.state_code_list
  list.each {|code| array_of_hashes << Scraper.find_in_states_array(code)}
  array_of_hashes.each do |hash|
    state = State.find_or_make_new(hash)
    self.all_states << state
    state.add_park(self)
    end
  
  
end

    def self.all_urls 
      arr = []
      Park.all.each do |park|
        arr << park.url
      end 
      return arr
    end
  
  #end of class
end