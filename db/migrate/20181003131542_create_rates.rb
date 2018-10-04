class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :from
      t.string :to
      t.float :amount

      t.timestamps
    end
  end
end
