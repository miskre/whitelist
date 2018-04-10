# == Schema Information
#
# Table name: agent_agents
#
#  id                            :integer          not null, primary key
#  owner_id                      :integer          not null
#  open_account_token            :string(255)
#  oversea_remittance_fee        :integer          default(0), not null
#  internal_transfer_fee         :integer          default(0), not null
#  incoming_funds_fiat_fee       :integer          default(0), not null
#  incoming_funds_crypt_fee      :integer          default(0), not null
#  incoming_funds_credidcard_fee :integer          default(0), not null
#  exchange_markup_fee           :integer          default(0), not null
#  exchange_fiat_fee             :integer          default(0), not null
#  exchange_crypt_fee            :integer          default(0), not null
#  card_charge_fee               :integer          default(0), not null
#  charge_back                   :integer          default(0), not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

require 'rails_helper'

describe Agent::Agent, type: :model do
  describe 'validates' do
    subject { build(:agent_agent, attributes) }

    describe '#owner' do
      let(:attributes) { { owner: owner } }

      context '既に他のagentのownerであるWallet::Userが指定されたとき' do
        let(:owner) { create(:agent_owner) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:owner]).to_not be_empty
        end
      end

      context '既に他のagentの所属であるWallet::Userが指定されたとき' do
        let(:owner) { create(:wallet_user, agent: build(:agent_agent)) }

        it do
          is_expected.to be_invalid
          expect(subject.errors[:owner_id]).to match_array ['は、既に他の代理店に属するUserを指定できません']
        end
      end
    end
  end
end
