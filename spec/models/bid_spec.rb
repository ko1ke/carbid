# == Schema Information
#
# Table name: bids
#
#  id         :bigint(8)        not null, primary key
#  price      :integer
#  suggestion :text(65535)
#  image      :string(255)
#  user_id    :bigint(8)
#  auction_id :bigint(8)
#  accepted   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Bid, type: :model do
  let(:user_a){FactoryBot.create(:user)}
  let(:user_b){FactoryBot.create(:user)}
  let(:auction){FactoryBot.create(:auction, user: user_a)}

  describe '#create' do
    it 'should bid user and auction user are different' do
      bid_a = FactoryBot.build(:bid, auction: auction, user: user_a)
      expect(bid_a).not_to be_valid
      bid_b = FactoryBot.build(:bid, auction: auction, user: user_b)
      expect(bid_b).to be_valid
    end
  end
end
