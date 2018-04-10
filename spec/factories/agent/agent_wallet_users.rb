FactoryGirl.define do
  factory :agent_agent_wallet_user, class: Agent::AgentWalletUser do
    trait :with_depends do
      after(:build) do |agent_agent_wallet_users|
        agent_agent_wallet_users.agent       = FactoryGirl.build(:agent_agent)
        agent_agent_wallet_users.wallet_user = FactoryGirl.build(:wallet_user)
      end
    end
  end
end
