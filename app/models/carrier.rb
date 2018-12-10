class Carrier < User
  has_many :tasks
  has_one_attached :image
end
