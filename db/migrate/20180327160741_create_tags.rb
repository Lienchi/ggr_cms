class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :tab
      t.string :col
      t.string :spreadsheet_id

      t.timestamps
    end
  end
end
