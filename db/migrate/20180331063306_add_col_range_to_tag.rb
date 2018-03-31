class AddColRangeToTag < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :col_range, :string
  end
end
