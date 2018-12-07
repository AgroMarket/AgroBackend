class Task < ApplicationRecord
  belongs_to :carrier
  belongs_to :ask
  belongs_to :member

  enum status: %i[Ожидает Доставлен]
end
