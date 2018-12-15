class My::BidsController < My::ApplicationController
  before_action :set_auction

  def index
    @bids = @auction.bids.all
  end

  private
  def set_auction
    @auction = Auction.find(params[:auction_id])
  end
end