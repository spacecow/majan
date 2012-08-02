class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :reserved_on

      t.timestamps
    end
  end
end
