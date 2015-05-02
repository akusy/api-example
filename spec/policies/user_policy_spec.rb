describe UserPolicy do
  let(:user) { create(:user) }
  let(:guest) { create(:user, :guest) }
  let(:admin) { create(:user, :admin) }

  subject { described_class }

  [:show?, :update?, :destroy?].each do |method|
    permissions method do
      it "denies access if user is not admin or owner" do
        expect(subject).not_to permit(guest, user)
      end

      it "grants access if user is admin" do
        expect(subject).to permit(admin, user)
      end

      it "grants access if user is owner" do
        expect(subject).to permit(user, user)
      end
    end
  end
end
