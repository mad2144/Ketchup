class Trainer
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
  key :email, String
  key :admin, Integer

  many :pokemon
  
  validates :email, presence: true, uniqueness: {message: "Email already used."}
end
