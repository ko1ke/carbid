class AuctionsController < ApplicationController
  def index
    @q = Auction.ongoing.includes(:car, :maker, :user).ransack(params[:q])
    @auctions = @q.result
  end
end
