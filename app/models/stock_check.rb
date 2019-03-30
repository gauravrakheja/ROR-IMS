class StockCheck < ApplicationRecord
  belongs_to :item
  belongs_to :stock_check_report, inverse_of: :stock_checks, touch: true
  after_save :sync_state

  state_machine initial: :pending do
    event :pass do
      transition %i{pending failed} => :passed
    end

    event :failure do
      transition %i{pending passed} => :failed
    end
  end

  def to_json
    {
      code: item.code,
      scanned: quantity,
      stored: item.quantity,
      updated_at: updated_at,
      status: "found",
      state: state,
      id: id
    }.to_json
  end

  private

  def sync_state
    return if quantity < item.quantity
    if quantity == item.quantity
      pass
    elsif  quantity > item.quantity
      failure
    end        
  end
end
