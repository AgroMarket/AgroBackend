require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing test for user_token" do
    it "routes to #login" do
      expect(post: '/api/login').to route_to("user_token#create")
    end
  end
end