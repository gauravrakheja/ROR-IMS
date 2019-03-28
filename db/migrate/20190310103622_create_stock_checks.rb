class CreateStockChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_checks do |t|
      t.references :item, foreign_key: true
      t.integer :quantity
      t.references :stock_check_report, foreign_key: true

      t.timestamps
    end
  end
end
