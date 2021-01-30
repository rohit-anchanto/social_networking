class ColumnChange < ActiveRecord::Migration[5.2]
  def change
    remove_column :likes, :post_id
    add_reference :likes, :likeable, polymorphic: true
  end
end
