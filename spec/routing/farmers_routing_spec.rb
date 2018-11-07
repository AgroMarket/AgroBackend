require "rails_helper"

RSpec.describe FarmersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/farmers").to route_to("farmers#index")
    end

    it "routes to #show" do
      expect(:get => "/farmers/1").to route_to("farmers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/farmers").to route_to("farmers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/farmers/1").to route_to("farmers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/farmers/1").to route_to("farmers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/farmers/1").to route_to("farmers#destroy", :id => "1")
    end
  end
end
