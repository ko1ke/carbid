class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all.ongoing
  end
end
