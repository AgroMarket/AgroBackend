class Task < ApplicationRecord
  belongs_to :carrier
  belongs_to :ask
  belongs_to :member

  enum status: %i[Ожидает Доставлен]

  after_update :ask_delivered

  def ask_delivered
    return unless status == "Доставлен"

    ask.update status: 2
  end
end
