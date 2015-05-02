describe Article do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to belong_to(:user) }

end
