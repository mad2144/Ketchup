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
     if self.type == "Normal"
	self.set_normal
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

  validate :name_exists
  validate :valid_dex
  after_validation :set_stats

  def name_exists
        if name.empty?
          errors.add(:name, "Every Pokemon must have a name, silly!")
        end
  end

  def valid_dex
        if pokedex_number <= 0
          errors.add(:pokedex_number, "Every Pokemon must have a valid pokedex number!")
        end
  end

end
