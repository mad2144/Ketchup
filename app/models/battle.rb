class Battle
  include MongoMapper::Document

  key :p1, String
  key :p2, String
  belongs_to :trainer

end
