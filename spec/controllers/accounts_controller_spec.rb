require 'rails_helper'

describe AccountsController, type: :controller do
  describe "GET #index" do
    let! (:accounts) {FactoryGirl.create_list(:account, 20)}
    before do
        get :index
    end
    it "returns http success" do
        expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected account attributes" do
      json_response = JSON.parse(response.body)
      json_response.each do |account|
        expect(account.keys).to include("id", "name")
      end
    end
    it "get ten accounts" do
      json_response = JSON.parse(response.body)
      expect(json_response.length).to be(10)
    end  
  end 
  describe "GET #show" do
    let! (:accounts) {FactoryGirl.create_list(:account, 20)}
    before do
        get :show, params: {:id => accounts[0].id}
    end
    it "returns http success" do
        expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected account attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to include("id", "name")
    end
    it "JSON body response contains match attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to include("id", "name")
      expect(json_response["name"]).to match(accounts[0][:name])
    end
  end 
  describe "POST #create" do
    let (:account) {FactoryGirl.attributes_for :account}
    before do
      post :create, params: {:account => account}
    end
    it "returns http success" do
        expect(response).to have_http_status(:success)
    end 
    it "JSON body response match account attributes" do
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to include("id", "name")
      expect(json_response["name"]).to match(account[:name])
    end 
  end
  describe "PUT #update" do
    let (:account) {FactoryGirl.create :account}
    let (:new_account) {FactoryGirl.attributes_for :account}
    before do
      put :update, params: {:account => new_account, :id => account.id}
    end
    it "returns http success" do
        expect(response).to have_http_status(:success)
    end 
    it "JSON body response match account attributes" do
      get :show, params: {:id => account.id}
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to match(new_account[:name])
    end 
  end 
end
