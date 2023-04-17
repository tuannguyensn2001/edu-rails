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
        expect(response).not_to have_http_status(:unprocessable_entity)
        expect(User.count).to eq(0)
      end
    end
  end
end