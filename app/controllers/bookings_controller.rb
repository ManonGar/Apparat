class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    @costume = Costume.find(params[:costume_id])
    @booking = Booking.new(booking_params)
    @booking.costume = @costume
    authorize @booking
    if @booking.save
      redirect_to costume_path(@costume)
    else
      render "/costumes/show"
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:beginning_date, :ending_date, :user_id, :costume_id)
  end
end
