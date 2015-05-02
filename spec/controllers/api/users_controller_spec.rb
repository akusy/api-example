describe Api::UsersController do
  let(:user) { create(:user) }

  context "Without basic authentication" do
    describe "#show" do
      before do
        get :show, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#index" do
      before do
        get :index, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#destroy" do
      before do
        delete :destroy, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#update" do
      before do
        put :update, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#create" do
      before do
        post :create, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end
  end

  context "With basic authentication" do
    before do
      http_authenticate_or_request user.email, user.password
    end

    describe "#show" do
      before do
        get :show, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:ok) }
    end

    describe "#update" do
      before do
        put :update, id: user.id, user: { name: "test" }, format: :json
      end

      it { is_expected.to respond_with(:ok) }
    end

    describe "#index" do
      before do
        get :index, format: :json
      end

      it { is_expected.to respond_with(:ok) }
    end

    describe "#destroy" do
      before do
        delete :destroy, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:no_content) }
    end

    describe "#create" do
      let(:params) { { name: "test", email: "john@example.com", password: "testtest", role: "user" } }

      it "returns status 200" do
        post :create, user: params, format: :json

        is_expected.to respond_with(:ok)
      end

      context "When user is not valid" do
        it "returns status 422" do
          post :create, user: params.slice(:email), format: :json

          is_expected.to respond_with(:unprocessable_entity)
        end
      end

    end
  end
end
