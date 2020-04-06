class State
  
  attr_accessor :name, :state_url 
  
  @@all = []
  
    def initialize(state_hash)
state_hash.each { |k, v| self.send("#{k}=", v) }
@@all << self
  end
  
  def self.make_from_collection(states_array)
    states_array.each {|state_hash| State.new(state_hash) }
  end
  
  def self.all
    @@all
  end
  
end