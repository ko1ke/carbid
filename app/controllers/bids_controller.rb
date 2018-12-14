class BidsController < ApplicationController
  before_action :set_auction

  def index
    @bids = @auction.bids.all
  end

  def new
    @bid = @auction.bids.new
  end

  def create
    @bid = @auction.bids.new(bid_params)
    @bid.user_id = current_user.id

    respond_to do |format|
      if @bid.save
        format.html { redirect_to auction_bids_url, notice: '新規入札されました。' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def set_auction
      @auction = Auction.find(params[:auction_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:price,
                                  :suggestion,
                                  :image,
                                  :auction_id)
    end
end
