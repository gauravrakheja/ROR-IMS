class AddQuantityDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :quantity, 0
  end
end
