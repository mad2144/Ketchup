include MMPaperclip
require 'paperclip'

class Pokemon
  include MongoMapper::Document
  include Paperclip::Glue

  key :name, String
  key :pokedex_number, Integer
  key :type, String
  key :species, String
  
  belongs_to :trainer
  belongs_to :party

  validate :name_exists
  validate :match

  def match
	if ((not party.nil?) && party.trainer != trainer)
	  errors.add(:party, "The party must be owned the same trainer")
	end
  end

  def name_exists
        if name.empty?
          errors.add(:name, "Every Pokemon must have a name, silly!")
        end
  end

  has_attached_file :avatar

  key :avatar_file_name, String

end
