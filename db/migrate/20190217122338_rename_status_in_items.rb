class RenameStatusInItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :status, :state
  end
end
