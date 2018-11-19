require "rails_helper"

RSpec.describe ConsumersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/consumers").to route_to("consumers#index")
    end

    it "routes to #show" do
      expect(:get => "/consumers/1").to route_to("consumers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/consumers").to route_to("consumers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/consumers/1").to route_to("consumers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/consumers/1").to route_to("consumers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/consumers/1").to route_to("consumers#destroy", :id => "1")
    end
  end
end
