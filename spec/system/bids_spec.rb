require 'rails_helper'

RSpec.describe 'Bids', type: :system do
  let(:bid){FactoryBot.create(:bid)}

  before do
    login_as bid.user, scope: :user
  end

  scenario 'buy buttons show unless auction is closed in my auction' do
    visit my_auction_bids_path(bid.auction)
    expect(page).to have_link '購入する', href: "/my/auctions/#{bid.auction.id}/bids/#{bid.id}/edit"
  end

  scenario 'User cannot show others bids in my auction' do
    other_user = FactoryBot.create(:user)
    login_as other_user, scope: :user
    visit my_auction_bids_path(bid.auction)
    expect(page).to have_content '権限がありません'
  end

  scenario 'User can bid to own auction' do
    other_user = FactoryBot.create(:user)
    login_as other_user, scope: :user
    visit edit_my_auction_bid_path(bid)
    expect(page).to have_content '権限がありません'
  end
end