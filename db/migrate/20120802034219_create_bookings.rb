class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :majan_table_id
      t.date :date
      t.string :name
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
