class Pokemon
  include MongoMapper::Document

  key :name, String
  key :pokedex_number, Integer
  key :type, String
  key :species, String
  
  belongs_to :trainer

  validate :name_exists

  def name_exists
        if name.empty?
          errors.add(:name, "Every Pokemon must have a name, silly!")
        end
  end
end
