class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all.ongoing.includes(:car, :maker)
  end
end
