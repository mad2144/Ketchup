class Trainer
  include MongoMapper::Document

  key :first_name, String
  key :last_name, String
  key :hometown, String
  key :motto, String
  key :email, String
  key :admin, Integer, :default => 0
  one :party
  many :pokemon
  
  validates :email, presence: true, uniqueness: {message: "Email already used."}
end
