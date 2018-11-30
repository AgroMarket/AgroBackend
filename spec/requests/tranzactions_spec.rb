require 'rails_helper'

RSpec.describe "Tranzactions", type: :request do
  describe "GET /tranzactions" do
    it "works! (now write some real specs)" do
      get tranzactions_path
      expect(response).to have_http_status(200)
    end
  end
end
