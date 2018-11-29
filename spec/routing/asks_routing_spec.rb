require "rails_helper"

RSpec.describe AsksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/asks").to route_to("asks#index")
    end

    it "routes to #show" do
      expect(:get => "/asks/1").to route_to("asks#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/asks").to route_to("asks#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/asks/1").to route_to("asks#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/asks/1").to route_to("asks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/asks/1").to route_to("asks#destroy", :id => "1")
    end
  end
end
