require 'rails_helper'

RSpec.describe "Farmers", type: :request do
  describe "GET /farmers" do
    it "works! (now write some real specs)" do
      get farmers_path
      expect(response).to have_http_status(200)
    end
  end
end
