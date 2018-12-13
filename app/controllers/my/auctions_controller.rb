class My::AuctionsController < My::ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]

  def index
    @auctions = current_user.owning_auctions.all
  end

  def show
  end

  def new
    @auction = Auction.new
  end

  def edit
  end

  def create
    @auction = Auction.new(auction_params)

    respond_to do |format|
      if @auction.save
        format.html {redirect_to [:my, :auctions], notice: 'オークションが作成されました。'}
        format.json {render :show, status: :created, location: @auction}
      else
        format.html {render :new}
        format.json {render json: @auction.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html {redirect_to [:my, :auctions], notice: 'オークションが更新されました。'}
        format.json {render :show, status: :ok, location: @auction}
      else
        format.html {render :edit}
        format.json {render json: @auction.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @auction.destroy
    respond_to do |format|
      format.html {redirect_to my_auctions_url, notice: 'オークションが削除されました。'}
      format.json {head :no_content}
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
