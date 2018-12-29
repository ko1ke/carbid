require 'rails_helper'

RSpec.describe 'Users', type: :system do

  let(:user){FactoryBot.create(:user)}

  scenario 'login with created user' do
    logout(:user)
    login_by_auto_fill(user)
    expect(page).to have_content 'ログインしました。'
    click_on 'ユーザー管理'
    expect(page).to have_content 'ログアウト'
  end
end