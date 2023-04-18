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
      it "return response error with invalid params" do
        mock_service = instance_double(Auth::Register, call: nil, errors: ["data not valid"])
        allow(Auth::Register).to receive(:new).and_return(mock_service)
        post :register, params: params
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include("message" => "data not valid")
      end
    end
  end
end