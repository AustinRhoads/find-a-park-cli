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
  
  def self.find_by_code(code)
    Activity.all.each do |act|
      if act.code == code 
        return act 
      end
    end
  end
  
end