class ChangeNumberToString < ActiveRecord::Migration
  def change
    change_column :numbers, :number, :string, null: false
  end
end
