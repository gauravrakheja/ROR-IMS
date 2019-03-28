class StockCheckReport < ApplicationRecord
  has_many :stock_checks, inverse_of: :stock_check_report
end
