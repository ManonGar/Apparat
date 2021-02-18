class AddCategoryToCostumes < ActiveRecord::Migration[6.0]
  def change
    add_column :costumes, :category, :string
  end
end
