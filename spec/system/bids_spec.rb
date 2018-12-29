require 'rails_helper'

RSpec.describe 'Bids', type: :system do
  let(:user_a) {FactoryBot.create(:user)}
  let(:user_b) {FactoryBot.create(:user)}
  let(:auction) {FactoryBot.create(:auction, user: user_a)}
  let(:bid) {FactoryBot.create(:bid, user: user_b, auction: auction)}

  describe 'Buy button' do
    scenario 'shows unless auction is closed in my auction' do
      bid
      login_as user_a, scope: :user

      visit my_auction_bids_path(auction)
      expect(page).to have_link '購入する', href: "/my/auctions/#{bid.auction.id}/bids/#{bid.id}/edit"

      visit edit_my_auction_bid_path(auction, bid)
      click_button 'この内容で購入する'
      expect(page).not_to have_link '購入する', href: "/my/auctions/#{bid.auction.id}/bids/#{bid.id}/edit"
    end
  end

  describe 'Access permission' do
    context 'my_auction' do
      it 'user shows own auctions' do
        login_as user_a, scope: :user
        visit my_auction_bids_path(bid.auction)
        expect(page).not_to have_content '権限がありません'
      end

      it 'user does not show others bids ' do
        login_as user_b, scope: :user
        visit my_auction_bids_path(bid.auction)
        expect(page).to have_content '権限がありません'
      end
    end

    context 'auction' do
      it 'user can bid to others auction' do
        login_as user_b, scope: :user
        visit new_auction_bid_path(auction)
        expect(page).not_to have_content '権限がありません'
      end
      it 'user cannot bid to own auction' do
        login_as user_a, scope: :user
        visit new_auction_bid_path(auction)
        expect(page).to have_content '権限がありません'
      end
    end

  end
end
