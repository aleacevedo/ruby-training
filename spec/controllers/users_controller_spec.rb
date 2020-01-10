require 'rails_helper'

describe UsersController, type: :controller do
    describe "GET #index" do
    let! (:users) {FactoryBot.create_list(:user, 20)}
    before do
        get :index
    end
    it "returns http success" do
        expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected account attributes" do
      json_response = JSON.parse(response.body)
      json_response.each do |account|
        expect(account.keys).to include("id", "email", "first_name", "last_name")
      end
    end
    it "get ten accounts" do
      json_response = JSON.parse(response.body)
      expect(json_response.length).to be(10)
    end  
  end 
end
