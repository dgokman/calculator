class CreateDecimals < ActiveRecord::Migration
  def change
    create_table :decimals do |t|
      t.string :value, null: false
    end
  end
end
