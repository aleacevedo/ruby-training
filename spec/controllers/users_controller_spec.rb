require 'rails_helper'

describe UsersController, type: :controller do
    describe "GET #index" do
    let! (:users) {create_list(:user, 20)}
    let (:user_schema) do
      {
        type: "object",
        required: ["id", "email", "first_name", "last_name"],
        properties: {
          id: {"type" => "integer"},
          email: {"type" => "string"},
          first_name: {"type" => "string"},
          last_name: {"type" => "string"}
        }
      }
    end
    before do
        get :index
    end
    it "returns http success" do
        expect(response).to have_http_status(:success)
    end
    it "JSON body response contains expected account attributes" do
      users_responded = response.parsed_body
      expect(JSON::Validator.validate(user_schema, users_responded, list: true)).to be true
    end
    it "responds with 10 users" do
      users_responded = response.parsed_body
      expect(users_responded.length).to be(10)
    end  
  end 
end
