class ChangeOperatorValueToFloat < ActiveRecord::Migration
  def change
    change_column :operators, :value, :float, null: false
  end
end
