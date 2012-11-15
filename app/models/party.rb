class Party
  include MongoMapper::Document
  key :name, String
  key :pokemon, Array

  belongs_to :trainer

  validates :name, presence: true, uniqueness: {message: "Party name already in use."}
end
