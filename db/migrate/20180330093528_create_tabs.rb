class CreateTabs < ActiveRecord::Migration[5.1]
  def change
    create_table :tabs do |t|
      t.string :name
      t.string :spreadsheet_id
      t.timestamps
    end
    add_column :tags, :tab_id, :string
  end
end
