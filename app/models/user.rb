class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :rememberable,
         :validatable,
         # :lockable,
         :timeoutable,
         :trackable,
         # :omniauthable,
         :recoverable
end
