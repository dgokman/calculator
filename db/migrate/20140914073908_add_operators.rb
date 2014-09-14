class AddOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.integer :value, null: false
    end
  end
end
