class AddCategory < ActiveRecord::Migration
  def change
    add_column :numbers, :category, :string, null: false
  end
end
