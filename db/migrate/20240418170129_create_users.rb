class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :car_id
      t.integer :bike_id

      t.timestamps
    end
  end
end
