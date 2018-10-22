class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are: :confirmable,
    # :lockable, :timeoutable, :trackable, :omniauthable,
  devise :database_authenticatable, :registerable, :rememberable,
         :validatable, :recoverable

  alias_method :authenticate, :valid_password?

  def self.from_token_payload(payload)
    self.find payload["sub"]
  end
end
