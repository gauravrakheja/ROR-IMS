class CreateSupplierDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :supplier_details do |t|
      t.string :name
      t.string :contact
      t.string :location
      t.integer :lead_time

      t.timestamps
    end
  end
end
