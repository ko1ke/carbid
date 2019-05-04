class CarsController < ApplicationController
  def index
    @maker = Maker.find(params[:maker_id])
    render json: @maker.cars.select(:id, :name)
  end
end
