FactoryGirl.define do
  factory :article do
    name "test"
    content "test content"
    association :user
  end
end
