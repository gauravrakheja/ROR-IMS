class StockCheckReport < ApplicationRecord
  has_many :stock_checks, inverse_of: :stock_check_report
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

  def passed?
    stock_checks.size == passed_stock_checks.size
  end
end
