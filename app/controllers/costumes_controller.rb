class CostumesController < ApplicationController
  before_action :set_costume, only: [:show, :update, :destroy, :edit]

  def index
    @costumes = policy_scope(Costume).order(created_at: :desc)
  end

  def new
    @costume = Costume.new
    authorize @costume
  end

  def show
  end

  def edit
    @booking = Booking.new
  end

  def create
    @costume = Costume.new(costume_params)
    authorize @costume
    if @costume.save
      redirect_to costume_path(@costume)
    else
      render :show
    end
  end

  def update
    if @costume.update(costumes_params)
      redirect_to costume_path(@costume), notice: "Costume was updated successfully!"
    else
      render :show
    end
  end

  def destroy
    @costume.destroy
    redirect_to costumes_path
  end

  private

  def set_costume
    @costume = Costume.find(params[:id])
    authorize @costume
  end

  def costume_params
    params.require(:costume).permit(:name, :year, :description, :price, :user_id)
  end
end
