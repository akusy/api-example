describe ArticleSerializer do
  let(:user) { build(:user)}
  let(:comment) { create(:comment, user: user) }

  it "creates user JSON" do
    serializer = CommentSerializer.new(comment).as_json["comment"]

    expect(serializer).to have_key :id
    expect(serializer).to have_key :content
    expect(serializer).to have_key :author
  end
end

