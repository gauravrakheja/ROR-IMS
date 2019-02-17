class AddDefaultToItem < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items, :state, "out_of_stock"
  end
end
