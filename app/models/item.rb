class Item < ApplicationRecord
  belongs_to :supplier_detail, optional: true
  validates :code, :description
  has_paper_trail

  state_machine initial: :out_of_stock do
    event :order do
      transition out_of_stock: :ordered
    end

    event :receive do
      transition ordered: :in_stock
    end

    event :process do
      transition in_stock: :processing
    end

    event :dispatch do
      transition processing: :dispatched
    end
  end
end
