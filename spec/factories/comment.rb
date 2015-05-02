FactoryGirl.define do
  factory :comment do
    content "test content"
    association :user
    association :article
  end
end
