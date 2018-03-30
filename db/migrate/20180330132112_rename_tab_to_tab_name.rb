class RenameTabToTabName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tags, :tab, :tab_name
  end
end
