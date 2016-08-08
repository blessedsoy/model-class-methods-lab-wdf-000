class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})  
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    both = sailors & motorboat_operators
    where(id: both.map(&:id))
  end

  def self.non_sailors
    non_sailors = self.all - sailors
    where(id: non_sailors.map(&:id))
  end

end
