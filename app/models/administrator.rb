class Administrator < User
    has_one_attached :image
    has_one_attached :logo
end
