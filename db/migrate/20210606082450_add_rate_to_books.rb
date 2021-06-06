class AddRateToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :rate, :float, null: false, default: 0
  end
end
