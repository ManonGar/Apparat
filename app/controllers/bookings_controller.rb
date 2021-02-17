class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    if current_user == current_user
      @costume = Costume.find(params[:costume_id])
      @booking = Booking.new(booking_params)
      @booking.costume = @costume
      @booking.user = current_user
      authorize @booking
      if @booking.save
        flash[:alert] = "Bravo vous venez de réserver un costume"
        redirect_to costume_path(@costume)
      else
        render "/costumes/show"
      end
    else
      render "/costumes/show"
    end
  end

  def destroy
    @costume = Costume.find(params[:costume_id])
    @booking = Booking.find(params[:id])
    @booking.costume = @costume
    @booking.destroy
    redirect_to costume_path(@costume)
  end

  private

  def booking_params
    params.require(:booking).permit(:beginning_date, :ending_date, :costume_id)
  end
end
