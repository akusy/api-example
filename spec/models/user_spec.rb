describe User do

  context "When user has role user or admin" do
    let!(:user) { create :user }

    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to ensure_length_of(:password).is_at_least(6).is_at_most(30) }

    it { is_expected.to validate_inclusion_of(:role).in_array(User::ROLES)}

    it { is_expected.not_to allow_value("unknown_role").for(:role) }
    it { is_expected.not_to allow_value('sdf', '1fesa@', '@example.com').for(:email) }
  end

  context "When user has guest role" do
    let(:user) { build :user, :guest }

    it "allows empty email and password" do
      expect(user).to be_valid
    end

    it "sets name 'Guest'" do
      user.validate
      expect(user.name).to eq "Guest"
    end

    it "removes email" do
      user.email = "test@example.com"
      user.validate

      expect(user.email).to be_nil
    end
  end

  describe "#user?" do
    let(:user) { build :user }

    it "returns true when user has role user" do
      expect(user.user?).to be_truthy
    end
  end

  describe "#admin?" do
    let(:user) { build :user, :admin }

    it "returns true when user has role admin" do
      expect(user.admin?).to be_truthy
    end
  end

  describe "#guest?" do
    let(:user) { build :user, :guest }

    it "returns true when user has role guest" do
      expect(user.guest?).to be_truthy
    end
  end
end
