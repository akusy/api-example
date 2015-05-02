describe UserSerializer do
  let(:user) { create(:user) }

  it "creates user JSON" do
    serializer = UserSerializer.new(user).as_json["user"]

    expect(serializer).to have_key :id
    expect(serializer).to have_key :name
    expect(serializer).to have_key :email
  end
end

