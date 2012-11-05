class Party
  include MongoMapper::Document
  key :name, String

  belongs_to :trainer
  many :pokemon
end
