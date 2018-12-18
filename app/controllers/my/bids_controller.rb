class My::BidsController < My::ApplicationController
  before_action :set_auction
  before_action :set_bid, only: [:edit, :update]

  def index
    @bids = @auction.bids.asc_price
  end

  def edit
  end

  def update
    respond_to do |format|
      if @bid.update!(bid_params) && @auction.update!(closed: true)
        format.html {redirect_to [:my, :auction, :bids], notice: '購入しました'}
      else
        format.html {render :edit}
      end
    end
  end

  private
  def set_auction
    @auction = Auction.find(params[:auction_id])
  end

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:accepted)
  end
end