class CalculatorNumbers < ActiveRecord::Migration
  def change
    create_table :numbers do |t|
      t.integer :number, null: false
    end
  end
end
