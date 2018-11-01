require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing test for categories" do
    it "routes to #home" do
      expect(get: '/api/home').to route_to("categories#home")
    end
  end
end
