namespace :add_deleted_field do
  desc "TODO"
  task deleted: :environment do
    Product.all.each do |product|
      product.deleted = false
      product.save
    end
  end
end