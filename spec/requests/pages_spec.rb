require 'rails_helper'

RSpec.describe "Список страниц", type: :request do
  describe "GET /api/pages" do
    before do
      get '/api/pages', headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
    end

    it "Response status 200" do
      expect(response).to have_http_status(200)
    end

    # it "Result is true" do
    #   p response.body
    #   body = JSON.parse(response.body)
    #   expect(body['message']).to eq("Список статических страниц")
    #   # expect(body['']).to eql(200)
    # end
  end
end

# RSpec.describe "Страница о нас", type: :request do
#   describe "GET /api/pages/2" do
#     before do
#       get '/api/pages/2', headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' }
#     end

#      it "Response status 200" do
#       expect(response).to have_http_status(200)
#     end
#   end
# end