class AddQuantityDefault1 < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :quantity, 1
  end
end
