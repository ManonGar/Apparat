class AddValidationToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :validation, :boolean, default: false
  end
end
