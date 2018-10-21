class User < ApplicationRecord
  rolify
  before_create :skip_confirmation_notification!
  before_update :skip_confirmation_notification!

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
