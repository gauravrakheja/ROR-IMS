class StockCheck < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :stock_check_report, inverse_of: :stock_checks, touch: true
  after_save :sync_state

  state_machine initial: :pending do
    event :pass do
      transition %i{pending failed} => :passed
    end

    event :failure do
      transition %i{pending passed} => :failed
    end

    event :not_found do
      transition %i{pending} => :item_not_found
    end
  end

  def to_json
    if item.present?
      {
        code: item.code,
        scanned: quantity,
        stored: item.quantity,
        updated_at: updated_at,
        status: "found",
        state: state,
        id: id
      }.to_json
    else
      {
        code: code,
        scanned: quantity,
        updated_at: updated_at,
        status: "not_found",
        state: state,
        id: id
      }.to_json
    end
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
