class BikesController < ApplicationController
  before_action :set_bike, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :isadmin, only: [:create, :edit, :update, :destroy]
  # GET /bikes
  # GET /bikes.json
  def index
    if current_user
      if User.count == 1
        current_user.update_attribute :admin, true
      end
    end
    @@searchParams = {
      name: params[:name],
      style: params[:style],
      min_price: params[:min_price],
      max_price: params[:max_price],
      order: params[:order]
    }
    @bikes = Bike.search(@@searchParams)
  end

  # GET /bikes/1
  # GET /bikes/1.json
  def show
  end

  # GET /bikes/new
  def new
    @bike = Bike.new
  end

  # GET /bikes/1/edit
  def edit
  end

  # POST /bikes
  # POST /bikes.json
  def create
    if isadmin
      @bike = Bike.new(bike_params)

      respond_to do |format|
        if @bike.save
          format.html { redirect_to @bike, notice: 'Bike was successfully created.' }
        else
          format.html { render :new }
        end
      end
    else
      redirect_to @bike, notice: 'Not Allowed'
    end
  end

  # PATCH/PUT /bikes/1
  # PATCH/PUT /bikes/1.json
  def update
    if isadmin
      respond_to do |format|
        if @bike.update(bike_params)
          format.html { redirect_to @bike, notice: 'Bike was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    else
      redirect_to @bike, notice: 'Not Allowed'
    end
  end

  # DELETE /bikes/1
  # DELETE /bikes/1.json
  def destroy
    if isadmin
      @bike.destroy
      respond_to do |format|
        format.html { redirect_to bikes_url, notice: 'Bike was successfully destroyed.' }
      end
    else
      redirect_to bikes_url, notice: 'Not Allowed'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bike
      @bike = Bike.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bike_params
      params.require(:bike).permit(:name, :style, :price, :picurl, :desc)
    end

    def isadmin
      if current_user.try(:admin)
        true
      else
        false
      end
    end
end
