class Activity 
  
  attr_accessor :name, :code 
  @@all = []
  def initialize(hash)
    hash.each {|k, v|self.send("#{k}=", v) }
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end