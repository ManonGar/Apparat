class CreateCostumes < ActiveRecord::Migration[6.0]
  def change
    create_table :costumes do |t|
      t.string :name
      t.string :description
      t.integer :year
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
