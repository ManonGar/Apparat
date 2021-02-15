class CostumesController < ApplicationController
  def index
    @costumes = Costume.all
  end

  def show
    @costume = Costume.find(params[:costume])
  end

  def new
    @costume = Costume.new
  end

  def create
    @costume = Costume.new(costume_params[:id])
    if @costume.save
      redirect_to costume_path(@costume)
    else
      render :new
    end
  end

  private

  def costume_params
    params.require(:costume).permit(:name, :year, :description, :price, :user_id)
  end
end
