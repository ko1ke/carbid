class My::AuctionsController < My::ApplicationController
  before_action :set_auction, only: [:edit, :update, :destroy]

  def index
    @auctions = current_user.owning_auctions.all.includes(:maker, :car)
  end

  def new
    @auction = current_user.owning_auctions.new
  end

  def edit
  end

  def create
    @auction = current_user.owning_auctions.new(auction_params)

    respond_to do |format|
      if @auction.save
        format.html {redirect_to [:my, :auctions], notice: 'オークションが作成されました。'}
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html {redirect_to [:my, :auctions], notice: 'オークションが更新されました。'}
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @auction.destroy
    respond_to do |format|
      format.html {redirect_to my_auctions_url, notice: 'オークションが削除されました。'}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_auction
    @auction = Auction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def auction_params
    params.require(:auction).permit(:close_at,
                                    :closed,
                                    :title,
                                    :description,
                                    :initial_price,
                                    :user_id,
                                    :maker_id,
                                    :car_id)
  end
end
