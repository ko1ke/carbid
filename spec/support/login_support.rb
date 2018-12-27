module LoginSupport
  def login_as(user)
    visit user_session_path
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: 'passoword'
    click_button 'ログイン'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end