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
        get :destroy, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#update" do
      before do
        get :update, id: user.id, format: :json
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
        get :update, id: user.id, user: { name: "test" }, format: :json
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
        get :destroy, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:ok) }
    end
  end
end
