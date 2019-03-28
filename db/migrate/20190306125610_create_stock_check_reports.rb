class CreateStockCheckReports < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_check_reports do |t|
      t.integer :number_of_items
      t.string :status

      t.timestamps
    end
  end
end
