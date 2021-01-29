class FixedColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :com, :comment
    rename_column :posts, :name, :title

  end
end
