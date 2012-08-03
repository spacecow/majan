class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :table_id
      t.time :start_at
      t.time :end_at

      t.timestamps
    end
  end
end
