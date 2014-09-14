class AddOperatorsCategory < ActiveRecord::Migration
  def change
    add_column :operators, :category, :string, null: false
  end
end
