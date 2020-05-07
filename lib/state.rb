class State
  
  attr_accessor :name, :state_url, :state_code 
  
  @@all = []
  @@all_names = []
    def initialize(state_hash)
state_hash.each { |k, v| self.send("#{k}=", v) }
@parks = []
@@all << self
@@all_names << self.name
  end
  
  def self.make_from_collection(states_array)
    states_array.each {|state_hash| State.new(state_hash) }
  end
  
  def self.all
    @@all
  end
  
  def parks
    @parks
  end
  
  def self.all_names
    @@all_names
  end
  
  def self.find_by_name(name)
    @@all.select {|state| state.name == name} 
  end
  
  def self.find_or_make_new(hash)
      finder = State.find_by_name(hash[:name])
     if finder == [] 
      state = Scraper.scrape_state(hash)
      return state
      elsif finder != []
      return finder[0]
    end
  end
  
  def add_park(park)
   # binding.pry
    if self.parks.include?(park) == false
      self.parks << park
    end
  end
  
end