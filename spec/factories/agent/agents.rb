FactoryGirl.define do
  factory :agent_agent, class: Agent::Agent do

    trait :with_depends do
      after(:build) do |agent_agent|
        agent_agent.owner = FactoryGirl.build(:wallet_user)
      end
    end
  end
end
