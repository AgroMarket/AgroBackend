require "rails_helper"

RSpec.describe ProducersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/producers").to route_to("producers#index")
    end

    it "routes to #show" do
      expect(:get => "/producers/1").to route_to("producers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/producers").to route_to("producers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/producers/1").to route_to("producers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/producers/1").to route_to("producers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/producers/1").to route_to("producers#destroy", :id => "1")
    end
  end
end
