class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :close_auction

  def close_auction
    # Wheneverの代わり
    Auction.must_be_closed.each do |auction|
      if auction.accept_and_close
        Rails.logger.info("オークション ID #{auction.id} を終了しました")
      else
        Rails.logger.error("オークション ID #{auction.id} の終了処理が失敗しました")
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :tel, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :tel, :avatar])
  end
end
