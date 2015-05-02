describe 'User API' do
  let(:user) { create :user, :admin }
  let(:json) { JSON.parse(response.body) }
  let(:auth_header) { basic_http_header user.email, user.password }

  context "When user doesn't exist" do

    [:get, :put, :delete].each do |method|
      it "returns not found" do
        send(method, "/api/users/12343", {}, auth_header)

        expect(response.code).to eq("404")
      end
    end
  end

  context "When user is fetched" do
    before do
      get "/api/users/#{ user.id }", {}, auth_header
    end

    it "returns user json" do
      expectation = user.as_json.slice("id", "name", "email")

      expect(json["user"]).to eq expectation
    end
  end

  context "When users are fetched" do
    before do
      get "/api/users/", { page: 1 }, auth_header
    end

    it "returns user json" do
      expectation = user.as_json.slice("id", "name", "email")

      expect(json["users"]).to include expectation
    end
  end

  context "When user is updated" do
    let(:params) { { email: "new_email@example.com", name: "new_name" } }

    before do
      put "/api/users/#{ user.id }", { user: params }, auth_header
    end

    it "returns user json" do
      expect(json["user"]["id"]).to eq user.id
      expect(json["user"]["name"]).to eq params[:name]
      expect(json["user"]["email"]).to eq params[:email]
    end
  end

  context "When user is updated" do
    let(:params) { { email: "new_email@example.com", name: "new_name", password: "testtest", role: "user" } }

    before do
      post "/api/users/", { user: params }, auth_header
    end

    it "returns new user json" do
      expect(json["user"]["id"]).not_to be_blank
      expect(json["user"]["name"]).to eq params[:name]
      expect(json["user"]["email"]).to eq params[:email]
    end
  end

  context "When user is destroyed" do
    before do
      delete "/api/users/#{ user.id }", {}, auth_header
    end

    it "returns no content" do
      expect(response.code).to eq("204")
    end
  end
end
