class StockCheck < ApplicationRecord
  belongs_to :item
  belongs_to :stock_check_report, inverse_of: :stock_checks, touch: true

  def to_json
    {
      code: item.code,
      scanned: quantity,
      stored: item.quantity,
      updated_at: updated_at,
      status: "found",
      id: id
    }.to_json
  end
end
