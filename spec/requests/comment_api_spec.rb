describe 'Comment API' do
  let(:user) { create :user }
  let(:article) { create :article, user: user }
  let!(:comment) { create :comment, user: user, article: article }
  let(:json) { JSON.parse(response.body) }
  let(:auth_header) { basic_http_header user.email, user.password }
  let(:params) { { content: "new_content" } }

  context "When comment doesn't exist" do

    [:get, :put, :delete].each do |method|
      it "returns not found" do
        send(method, "/api/users/#{ user.id }/articles/#{ article.id }/comments/12343", {}, auth_header)

        expect(response.code).to eq("404")
      end
    end
  end

  context "When comment is fetched" do
    before do
      get "/api/users/#{ user.id }/articles/#{ article.id }/comments/#{ comment.id }", {}
    end

    it "returns comment json" do
      expectation = comment.as_json.slice("id", "content").merge("author" => user.name)

      expect(json["comment"]).to eq expectation
    end
  end

  context "When comments are fetched" do
    before do
      get "/api/users/#{ user.id }/articles/#{ article.id }/comments/", { page: 1 }
    end

    it "returns comment json" do
      expectation = comment.as_json.slice("id", "content").merge("author" => user.name)

      expect(json["comments"]).to include expectation
    end
  end

  context "When comment is updated" do
    before do
      put "/api/users/#{ user.id }/articles/#{ article.id }/comments/#{ comment.id }", { comment: params }, auth_header
    end

    it "returns comment json" do
      expect(json["comment"]["id"]).to eq comment.id
      expect(json["comment"]["content"]).to eq params[:content]
    end
  end

  context "When comment is updated" do
    before do
      post "/api/users/#{ user.id }/articles/#{ article.id }/comments/", { comment: params }, auth_header
    end

    it "returns new comment json" do
      expect(json["comment"]["id"]).not_to be_blank
      expect(json["comment"]["content"]).to eq params[:content]
    end
  end

  context "When comment is destroyed" do
    before do
      delete "/api/users/#{ user.id }/articles/#{ article.id }/comments/#{ comment.id }", {}, auth_header
    end

    it "returns no content" do
      expect(response.code).to eq("204")
    end
  end
end
