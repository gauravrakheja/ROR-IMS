class AddCodeToStockCheck < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_checks, :code, :string
  end
end
