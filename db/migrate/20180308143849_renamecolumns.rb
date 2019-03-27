class Renamecolumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :prayers, :public?, :is_public
    rename_column :prayers, :anonymous?, :is_anonymous
    rename_column :groups, :public?, :is_public
  end
end
