class RenameSpreadsheetIdInSpreadsheets < ActiveRecord::Migration[5.1]
  def change
    rename_column :spreadsheets, :spreadsheet_id, :name
  end
end
