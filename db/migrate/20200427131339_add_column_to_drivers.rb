class AddColumnToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :name, :string
    add_column :drivers, :tel, :string
    add_column :drivers, :car_number, :string
  end
end
