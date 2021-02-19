class DashboardController < ApplicationController
  def dashboard
    @sum = 0
    current_user.costumes.each do |costume|
      @sum += costume.bookings.length
    end
  end
end
