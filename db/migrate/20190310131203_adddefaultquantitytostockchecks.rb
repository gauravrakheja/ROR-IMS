class Adddefaultquantitytostockchecks < ActiveRecord::Migration[5.2]
  def change
    change_column_default :stock_checks, :quantity, 1
  end
end
