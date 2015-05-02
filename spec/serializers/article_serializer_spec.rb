describe ArticleSerializer do
  let(:user) { build(:user)}
  let(:article) { create(:article, user: user) }

  it "creates user JSON" do
    serializer = ArticleSerializer.new(article).as_json["article"]

    expect(serializer).to have_key :id
    expect(serializer).to have_key :name
    expect(serializer).to have_key :content
    expect(serializer).to have_key :author
  end
end

