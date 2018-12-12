class My::AuctionsController < My::ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]

  # GET /my/auctions
  # GET /my/auctions.json
  def index
    @auctions = current_user.owning_auctions.all
  end

  # GET /my/auctions/1
  # GET /my/auctions/1.json
  def show
  end

  # GET /my/auctions/new
  def new
    @auction = Auction.new
  end

  # GET /my/auctions/1/edit
  def edit
  end

  # POST /my/auctions
  # POST /my/auctions.json
  def create
    @auction = Auction.new(auction_params)

    respond_to do |format|
      if @auction.save
        format.html { redirect_to @auction, notice: 'Auction was successfully created.' }
        format.json { render :show, status: :created, location: @auction }
      else
        format.html { render :new }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my/auctions/1
  # PATCH/PUT /my/auctions/1.json
  def update
    respond_to do |format|
      if @auction.update(auction_params)
        format.html { redirect_to @auction, notice: 'Auction was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction }
      else
        format.html { render :edit }
        format.json { render json: @auction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my/auctions/1
  # DELETE /my/auctions/1.json
  def destroy
    @auction.destroy
    respond_to do |format|
      format.html { redirect_to my_auctions_url, notice: 'Auction was successfully destroyed.' }
      format.json { head :no_content }
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
                                      :initial_price)
    end
end
