class CreateTables < ActiveRecord::Migration
  def change
    create_table :majan_tables do |t|
      t.integer :day_id
      t.integer :no

      t.timestamps
    end
  end
end
