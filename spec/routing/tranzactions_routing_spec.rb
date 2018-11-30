require "rails_helper"

RSpec.describe TranzactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tranzactions").to route_to("tranzactions#index")
    end

    it "routes to #show" do
      expect(:get => "/tranzactions/1").to route_to("tranzactions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tranzactions").to route_to("tranzactions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tranzactions/1").to route_to("tranzactions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tranzactions/1").to route_to("tranzactions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tranzactions/1").to route_to("tranzactions#destroy", :id => "1")
    end
  end
end
