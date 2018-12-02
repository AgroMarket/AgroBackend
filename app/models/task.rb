class Task < ApplicationRecord
  belongs_to :ask
  belongs_to :user

  enum status: %i[Ожидает Доставлен]
end
