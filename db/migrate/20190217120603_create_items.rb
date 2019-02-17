class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :code
      t.integer :quantity
      t.decimal :price
      t.string :status
      t.string :description
      t.string :internal_reference
      t.references :supplier_detail

      t.timestamps
    end
  end
end
