require 'rails_helper'

RSpec.describe 'Auctions', type: :system do
  let(:user_a){FactoryBot.create(:user)}
  let(:auction){FactoryBot.create(:auction, user: user_a)}
  let(:user_b){FactoryBot.create(:user, name: 'other')}

  describe 'gavel icons to bids' do
    scenario 'do not show for own auction' do
      auction
      login_as(user_a, :scope => :user)
      visit root_path
      expect(page).not_to have_css '.fa-gavel'
    end

    scenario 'shows when logout' do
      auction
      login_as(user_b, :scope => :user)
      visit root_path
      expect(page).to have_css '.fa-gavel'
    end
  end

  scenario 'some items do not show in view when updating' do
    login_as(user_a, :scope => :user)
    visit edit_my_auction_path(auction)
    expect(page).not_to have_content 'メーカー'
    expect(page).not_to have_content '車名'
    expect(page).not_to have_content '始値'
    expect(page).not_to have_content ' 終了日時'
  end
end