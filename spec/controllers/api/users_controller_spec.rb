describe Api::UsersController do
  let(:user) { create(:user) }

  context "Without basic authentication" do
    describe "#show" do
      before do
        get :show, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end
  end

  context "With basic authentication" do
    describe "#show" do
      before do
        http_authenticate_user user.email, user.password
        get :show, id: user.id, format: :json
      end

      it { is_expected.to respond_with(:ok) }
    end
  end
end
