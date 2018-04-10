FactoryGirl.define do
  factory :wallet_user, class: Wallet::User do
    nickname { Faker::Internet.user_name(5..20) }
    email    { Faker::Internet.email }
    password 'password'
    email_confirmed true

    factory :agent_owner do
      after :build do |wallet_user|
        wallet_user.owned_agent = FactoryGirl.build(:agent_agent)
      end
    end

    trait :kyc_pending do
      after(:build) do |wallet_user|
        wallet_user.kyc_paper = FactoryGirl.build(:wallet_kyc_paper)
      end
    end

    trait :kyc_accepted do
      after(:build) do |wallet_user|
        wallet_user.kyc_paper = FactoryGirl.build(:wallet_kyc_paper)
      end
    end
  end
end
