describe Api::ArticlesController do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  context "When authentication and authorization is not required" do
    describe "#show" do
      before do
        get :show, id: article.id, user_id: user.id, format: :json
      end

      it { expect(assigns(:current_user)).to be_a(User) }

      it { is_expected.to respond_with(:ok) }
    end

    describe "#index" do
      before do
        get :index, user_id: user.id, format: :json
      end

      it { expect(assigns(:current_user)).to be_a(User) }

      it { is_expected.to respond_with(:ok) }
    end
  end

  context "Without basic authentication" do
    describe "#destroy" do
      before do
        delete :destroy, id: article.id, user_id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#update" do
      before do
        put :update, id: article.id, user_id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end

    describe "#create" do
      let(:params) { { content: "test" } }

      before do
        post :create, article: params, user_id: user.id, format: :json
      end

      it { is_expected.to respond_with(:unauthorized) }
    end
  end

  context "With basic authentication" do

    context "With authorization" do
      before do
        http_authenticate_or_request user.email, user.password
      end

      describe "#update" do
        before do
          put :update, id: article.id, user_id: user.id, article: { name: "test" }, format: :json
        end

        it { is_expected.to respond_with(:ok) }
      end


      describe "#destroy" do
        before do
          delete :destroy, id: article.id, user_id: user.id, format: :json
        end

        it { is_expected.to respond_with(:no_content) }
      end
    end

    context "Without authorization" do
      let(:unauthorized_user) { create(:user) }

      before do
        http_authenticate_or_request unauthorized_user.email, unauthorized_user.password
      end

      describe "#update" do
        before do
          put :update, id: article.id, user_id: user.id, article: { content: "test" }, format: :json
        end

        it { is_expected.to respond_with(:unauthorized) }
      end


      describe "#destroy" do
        before do
          delete :destroy, id: article.id, user_id: user.id, format: :json
        end

        it { is_expected.to respond_with(:unauthorized) }
      end
    end
  end
end
