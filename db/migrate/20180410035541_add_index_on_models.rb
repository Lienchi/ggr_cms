class AddIndexOnModels < ActiveRecord::Migration[5.1]
  def change
    add_index :spreadsheets, :name
    add_index :tabs, :spreadsheet_id
    add_index :tags, [:tab_id, :category_id]
    add_index :categories, :name, unique: true
  end
end
