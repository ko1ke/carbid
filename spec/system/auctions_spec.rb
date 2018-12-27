require 'rails_helper'

RSpec.describe 'Auctions', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @auction = FactoryBot.create(:auction)
    @auction.update!(user: @user1)
    @user2 = FactoryBot.create(:user)
  end

  scenario 'gavel icon does not show for my auction' do
    login_as @user1
    visit root_path
    expect(page).not_to have_css '.fa-gavel'
  end

  scenario 'gavel icon shows when logout' do
    login_as @user2
    visit root_path
    expect(page).to have_css '.fa-gavel'
  end

  scenario 'some items do not show in view when updating' do
    login_as @user1
    visit edit_my_auction_path(@auction)
    expect(page).not_to have_content 'メーカー'
    expect(page).not_to have_content '車名'
    expect(page).not_to have_content '始値'
    expect(page).not_to have_content ' 終了日時'
  end
end