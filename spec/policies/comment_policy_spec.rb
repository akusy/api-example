describe CommentPolicy do
  let(:user) { create(:user) }
  let(:any_user) { create(:user) }
  let(:guest) { create(:user, :guest) }
  let(:admin) { create(:user, :admin) }
  let(:comment) { create(:comment, user: user) }

  subject { described_class }

  [:update?, :destroy?].each do |method|
    permissions method do
      it "denies access if user is not admin or owner" do
        expect(subject).not_to permit(guest, comment)
      end

      it "grants access if user is admin" do
        expect(subject).to permit(admin, comment)
      end

      it "grants access if user is owner" do
        expect(subject).to permit(user, comment)
      end
    end
  end

  permissions :create? do
    it "denies access if user is guest" do
      expect(subject).not_to permit(guest, comment)
    end

    it "grants access if user is admin" do
      expect(subject).to permit(admin, comment)
    end

    it "grants access if any user" do
      expect(subject).to permit(any_user, comment)
    end
  end
end
