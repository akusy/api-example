describe 'Article API' do
  let(:user) { create :user }
  let!(:article) { create :article, user: user }
  let(:json) { JSON.parse(response.body) }
  let(:auth_header) { basic_http_header user.email, user.password }
  let(:params) { { content: "new_content", name: "new_name"} }

  context "When article doesn't exist" do

    [:get, :put, :delete].each do |method|
      it "returns not found" do
        send(method, "/api/users/#{user.id}/articles/12343", {}, auth_header)

        expect(response.code).to eq("404")
      end
    end
  end

  context "When article is fetched" do
    before do
      get "/api/users/#{user.id}/articles/#{ article.id }", {}
    end

    it "returns article json" do
      expectation = article.as_json.slice("id", "name", "content").merge("author" => user.name)

      expect(json["article"]).to eq expectation
    end
  end

  context "When articles are fetched" do
    before do
      get "/api/users/#{user.id}/articles/", { page: 1 }
    end

    it "returns article json" do
      expectation = article.as_json.slice("id", "name", "content").merge("author" => user.name)

      expect(json["articles"]).to include expectation
    end
  end

  context "When article is updated" do
    before do
      put "/api/users/#{user.id}/articles/#{ article.id }", { article: params }, auth_header
    end

    it "returns article json" do
      expect(json["article"]["id"]).to eq article.id
      expect(json["article"]["name"]).to eq params[:name]
      expect(json["article"]["content"]).to eq params[:content]
    end
  end

  context "When article is updated" do
    before do
      post "/api/users/#{user.id}/articles/", { article: params }, auth_header
    end

    it "returns new article json" do
      expect(json["article"]["id"]).not_to be_blank
      expect(json["article"]["name"]).to eq params[:name]
      expect(json["article"]["content"]).to eq params[:content]
    end
  end

  context "When article is destroyed" do
    before do
      delete "/api/users/#{user.id}/articles/#{ article.id }", {}, auth_header
    end

    it "returns no content" do
      expect(response.code).to eq("204")
    end
  end
end
