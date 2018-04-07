class AddDimensionToTab < ActiveRecord::Migration[5.1]
  def change
    add_column :tabs, :dimension, :boolean, default: true
  end
end
