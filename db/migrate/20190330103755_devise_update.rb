class DeviseUpdate < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :encrypted_password, true
  end
end
