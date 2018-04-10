# == Schema Information
#
# Table name: agent_agent_wallet_users
#
#  id             :integer          not null, primary key
#  agent_agent_id :integer
#  wallet_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

describe Agent::AgentWalletUser, type: :model do
  describe 'validates' do
    subject { build(:agent_agent_wallet_user, attributes) }

    describe '#wallet_user' do
      let(:attributes) { { wallet_user: wallet_user } }

      context '既に他のagentのownerであるWallet::Userが指定されたとき' do
        let(:wallet_user) { create(:agent_owner) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:wallet_user_id]).to_not be_empty
        end

        context 'Wallet::Userモデルのhas_many_throughによる呼び出しのとき' do
          subject { build(:agent_owner, agent: build(:agent_agent)) }
          it { is_expected.to be_invalid }
        end

        context 'Agent::Agentモデルのhas_many_throughによる呼び出しのとき' do
          subject { build(:agent_agent, :with_depends, wallet_users: [create(:agent_owner)]) }
          it { is_expected.to be_invalid }
        end
      end

      context '既に他のagentの所属であるWallet::Userが指定されたとき' do
        let(:wallet_user) { create(:wallet_user, agent: build(:agent_agent, :with_depends)) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:wallet_user]).to_not be_empty
        end

        # Wallet::Userモデルのhas_many_throughによる呼び出しのときは、has_oneなので起こりえない

        context 'Agent::Agentモデルのhas_many_throughによる呼び出しのとき' do
          subject { build(:agent_agent, :with_depends, wallet_users: [wallet_user]) }

          it do
            is_expected.to be_invalid
            expect(subject.errors[:agent_wallet_users]).to_not be_empty
          end
        end
      end
    end
  end
end
