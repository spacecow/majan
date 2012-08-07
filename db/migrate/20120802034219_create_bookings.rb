class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :majan_table_id
      t.integer :day_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
