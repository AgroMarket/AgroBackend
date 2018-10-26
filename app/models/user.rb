class User < ApplicationRecord
  # validates :name, presence: true

  rolify

  has_one :farmer
  has_many :orders
  has_one :cart

  after_create :assign_default_role

  # before_create :skip_confirmation_notification!
  # before_update :skip_confirmation_notification!

  # Include default devise modules. Others available are: :confirmable,
    # :lockable, :timeoutable, :trackable, :omniauthable,
  devise :database_authenticatable, :registerable, :rememberable,
         :validatable, :recoverable


  alias_method :authenticate, :valid_password?

  def self.from_token_payload(payload)
    self.find payload["sub"]
  end

  private

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end

end
