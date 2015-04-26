FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name "Arek"
    password 'password'
    role "user"

    trait :admin do
      role "admin"
    end

    trait :guest do
      email nil
      password nil
      role "guest"
    end

  end
end
