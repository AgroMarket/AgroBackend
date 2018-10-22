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

  # Include default devise modules. Others available are: :confirmable,
    # :lockable, :timeoutable, :trackable, :omniauthable,
  devise :database_authenticatable, :registerable, :rememberable,
         :validatable, :recoverable

  alias_method :authenticate, :valid_password?

  def self.from_token_payload(payload)
    self.find payload["sub"]
  end

end
