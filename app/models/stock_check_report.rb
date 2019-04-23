require "csv"
class StockCheckReport < ApplicationRecord
  has_many :stock_checks, inverse_of: :stock_check_report, dependent: :destroy
  has_many :failed_stock_checks,
           -> { where(state: "failed") },
           class_name: "StockCheck",
           inverse_of: :stock_check_report
  has_many :passed_stock_checks, 
           -> { where(state: "passed") },
           class_name: "StockCheck",
           inverse_of: :stock_check_report
  has_many :pending_stock_checks, 
           -> { where(state: "pending") },
           class_name: "StockCheck",
           inverse_of: :stock_check_report
  has_many :item_not_found_stock_checks,
           -> { where(state: "item_not_found") },
           class_name: "StockCheck",
           inverse_of: :stock_check_report

  def passed?
    stock_checks.size == passed_stock_checks.size
  end

  def status
    passed? ? "PASSED" : "FAILED"
  end

  def to_csv(options={})
    CSV.generate(options) do |csv|
      csv << [status]
      csv << %w{Item\ Code Quantity\ During\ Stock\ Check Quantity\ in\ Warehouse Status}
      stock_checks.each do |stock_check|
        csv << [
          stock_check.code_or_item_code,
          stock_check.quantity,
          stock_check.item.try(:quantity),
          stock_check.human_state_name
        ]
      end
    end
  end
end
