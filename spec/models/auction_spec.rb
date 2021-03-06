# == Schema Information
#
# Table name: auctions
#
#  id            :bigint(8)        not null, primary key
#  user_id       :bigint(8)
#  close_at      :datetime         not null
#  closed        :boolean          default(FALSE)
#  title         :string(255)      not null
#  description   :text(65535)      not null
#  initial_price :integer          default(0)
#  maker_id      :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  car_id        :bigint(8)
#

require 'rails_helper'

RSpec.describe Auction, type: :model do
  before do
    @auction = FactoryBot.create(:auction)
    @maker =  FactoryBot.create(:maker)
    @car = Car.create(maker: @maker, name: 'hoge')
  end

  describe 'Creation' do
    it 'should be required user association' do
      @auction.user_id = nil
      expect(@auction).not_to be_valid
    end

    it 'should maker has correct car' do
      @auction.maker = @maker
      @auction.car = @car
      expect(@auction).to be_valid
    end
  end
end
