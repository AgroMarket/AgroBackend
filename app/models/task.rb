class Task < ApplicationRecord
  belongs_to :ask
  belongs_to :user
end
