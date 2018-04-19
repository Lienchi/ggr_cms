class DropTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :spreadsheets
    drop_table :tabs
    drop_table :tags
  end
end
