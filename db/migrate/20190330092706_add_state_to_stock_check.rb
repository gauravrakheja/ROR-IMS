class AddStateToStockCheck < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_checks, :state, :string
  end
end
