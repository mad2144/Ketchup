include MMPaperclip
require 'paperclip'

class Pokemon
  include MongoMapper::Document
  include Paperclip::Glue

  belongs_to :trainer

  key :name, String
  key :nickname, String
  key :pokedex_number, Integer
  key :type, String
  key :species, String

  key :HP, Float, :default => 50.0
  key :HP_MAX, Float, :default => 50.0
  key :ATK, Float, :default => 50.0
  key :DEF, Float, :default => 50.0
  key :SATK, Float, :default => 50.0
  key :SDEF, Float, :default => 50.0
  key :SPD, Float, :default => 50.0

  key :fainted, Boolean, :default => false
  
  has_attached_file :avatar

  key :avatar_file_name, String

  def set_stats

     self.fainted = false

     if self.type.split('/').first == "Normal"
	self.set_normal
     elsif self.type.split('/').first == "Fighting"
	self.set_fighting
     elsif self.type.split('/').first == "Flying"
	self.set_flying
     elsif self.type.split('/').first == "Poison"
	self.set_poison
     elsif self.type.split('/').first == "Ground"
	self.set_ground
     elsif self.type.split('/').first == "Rock"
	self.set_rock
     elsif self.type.split('/').first == "Bug"
	self.set_bug
     elsif self.type.split('/').first == "Ghost"
	self.set_ghost
     elsif self.type.split('/').first == "Steel"
	self.set_steel
     elsif self.type.split('/').first == "Water"
	self.set_water
     elsif self.type.split('/').first == "Fire"
	self.set_fire
     elsif self.type.split('/').first == "Grass"
	self.set_grass
     elsif self.type.split('/').first == "Electric"
	self.set_electric
     elsif self.type.split('/').first == "Psychic"
	self.set_psychic
     elsif self.type.split('/').first == "Ice"
	self.set_ice
     elsif self.type.split('/').first == "Dragon"
	self.set_dragon 
     elsif self.type.split('/').first == "Dark"
	self.set_dark
     end
  end

  def set_normal
     self.HP = 76.67
     self.HP_MAX = 76.67
     self.ATK = 71.50
     self.DEF = 58.84
     self.SATK = 55.86
     self.SDEF = 62.93
     self.SPD = 67.72
  end

  def set_fighting
     self.HP = 73.27
     self.HP_MAX = 73.27
     self.ATK = 97.05
     self.DEF = 69.17
     self.SATK = 60.78
     self.SDEF = 70.51
     self.SPD = 70.80
  end

  def set_flying
     self.HP = 69.77
     self.HP_MAX = 69.77
     self.ATK = 75.65
     self.DEF = 66.12
     self.SATK = 71.39
     self.SDEF = 69.85
     self.SPD = 82.55
  end

  def set_poison
     self.HP = 62.47
     self.HP_MAX = 62.47
     self.ATK = 68.4
     self.DEF = 62.26
     self.SATK = 65.53
     self.SDEF = 64.77
     self.SPD = 63.46
  end

  def set_ground
     self.HP = 73.37
     self.HP_MAX = 73.37
     self.ATK = 86.83
     self.DEF = 82.42
     self.SATK = 55.93
     self.SDEF = 60.97
     self.SPD = 57.49
  end

  def set_rock
     self.HP = 64.79
     self.HP_MAX = 64.79
     self.ATK = 88.09
     self.DEF = 107.57
     self.SATK = 56.49
     self.SDEF = 69.04
     self.SPD = 46.96
  end

  def set_bug
     self.HP = 56.03
     self.HP_MAX = 56.03
     self.ATK = 67.66
     self.DEF = 70.08
     self.SATK = 53.89
     self.SDEF = 64.09
     self.SPD = 59.82
  end

  def set_ghost
     self.HP = 64.21
     self.HP_MAX = 64.21
     self.ATK = 68.21
     self.DEF = 73.86
     self.SATK = 80.82
     self.SDEF = 77.46
     self.SPD = 62.18
  end

  def set_steel
     self.HP = 65.45
     self.HP_MAX = 64.45
     self.ATK = 85.79
     self.DEF = 110.79
     self.SATK = 70.87
     self.SDEF = 82.95
     self.SPD = 55.61
  end

  def set_fire
     self.HP = 69.34
     self.HP_MAX = 69.34
     self.ATK = 80.88
     self.DEF = 66.30
     self.SATK = 87.80
     self.SDEF = 72.62
     self.SPD = 71.54
  end

  def set_water
     self.HP = 70.79
     self.HP_MAX = 70.79
     self.ATK = 70.53
     self.DEF = 72.01
     self.SATK = 71.40
     self.SDEF = 68.18
     self.SPD = 63.77
  end

  def set_grass
     self.HP = 65.29
     self.HP_MAX = 65.29
     self.ATK = 70.29
     self.DEF = 69.51
     self.SATK = 73.51
     self.SDEF = 71.10
     self.SPD = 60.26
  end

  def set_electric
     self.HP = 62.45
     self.HP_MAX = 62.45
     self.ATK = 69.32
     self.DEF = 66.11
     self.SATK = 80.61
     self.SDEF = 72.73
     self.SPD = 81.27
  end

  def set_psychic
     self.HP = 68.43
     self.HP_MAX = 68.43
     self.ATK = 65.54
     self.DEF = 71.68
     self.SATK = 88.58
     self.SDEF = 83.14
     self.SPD = 72.22
  end

  def set_ice
     self.HP = 73.93
     self.HP_MAX = 73.93
     self.ATK = 75.13
     self.DEF = 71.57
     self.SATK = 79.13
     self.SDEF = 80.23
     self.SPD = 69.60
  end

  def set_dragon
     self.HP = 82.43
     self.HP_MAX = 82.43
     self.ATK = 103.93
     self.DEF = 83.17
     self.SATK = 87.67
     self.SDEF = 81.17
     self.SPD = 79.47
  end

  def set_dark
     self.HP = 67.05
     self.HP_MAX = 67.05
     self.ATK = 89.64
     self.DEF = 65.72
     self.SATK = 70.69
     self.SDEF = 63.62
     self.SPD = 73.95
  end

  validate :name_exists
  validate :valid_dex
  after_create :set_stats

  def name_exists
        if name.empty?
          errors.add(:name, "Every Pokemon must have a name, silly!")
        end
  end

  def valid_dex
        if pokedex_number < 0
          errors.add(:pokedex_number, "Every Pokemon must have a valid pokedex number!")
        end
  end

end
