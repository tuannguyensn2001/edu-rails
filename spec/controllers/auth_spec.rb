require "rails_helper"

describe AuthController, type: :controller do
  describe "POST # register" do
    context "with valid params" do
      let (:params) do
        {
          email: "tuannguyensn2001a@gmail.com",
          username: "tuannguyensn2001",
          password: "tuannguyensn2001"
        }
      end
      it "return response success" do
        post :register, params: params
        expect(response).to have_http_status(:ok)
        expect(User.count).to eq(1)
        expect(User.first.email).to eq("tuannguyensn2001a@gmail.com")
      end
    end

    context "with invalid params" do
      let (:params) do
        {
          email: ""
        }
      end
      it "return response error" do
        post :register, params: params
        expect(response).not_to have_http_status(:ok)
        expect(User.count).to eq(0)
      end
    end
  end

  describe "POST login" do
    let(:user) { create(:user, email: "tuannguyensn2001a@gmail.com", password: BCrypt::Password.create("123456")) }

    context "with valid credentials" do
      it "returns a success message and access and refresh tokens" do
        post :login, params: { email: user.email, password: "123456" }

        expect(response).to have_http_status(:ok)

        expect(JSON.parse(response.body)).to include("message" => "success", "data" => { "access_token" => a_kind_of(String), "refresh_token" => a_kind_of(String) })
      end
    end

    context "with invalid credentials" do
      it "returns a bad request status and an error message" do
        post :login, params: { email: user.email, password: "wrong_password" }

        expect(response).not_to have_http_status(:ok)
      end
    end
  end
end