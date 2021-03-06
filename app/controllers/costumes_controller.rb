class CostumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_costume, only: [:show, :update, :destroy, :edit]

  def index
    @costumes = policy_scope(Costume).order(created_at: :desc)
    if params[:query]
      @costumes = Costume.search_by_name_and_category(params[:query])
    else
      @costumes = policy_scope(Costume).order(created_at: :desc)
    end
  end

  def new
    @costume = Costume.new
    authorize @costume
  end

  def show
    @booking = Booking.new
  end

  def edit
    @booking = Booking.new
  end

  def create
    @costume = Costume.new(costume_params)
    @costume.user = current_user
    authorize @costume
    if @costume.save
      redirect_to costume_path(@costume)
    else
      render :new
    end
  end

  def update
    if @costume.update(costume_params)
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
    params.require(:costume).permit(:name, :year, :description, :category, :price, :user_id, photos: [])
  end
end
