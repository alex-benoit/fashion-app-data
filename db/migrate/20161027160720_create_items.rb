class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand
      t.integer :sku
      t.integer :int_product_code
      t.text :details
      t.text :size
      t.string :color
      t.float :price_gbp
      t.float :price_eur
      t.string :washing
      t.string :materials

      t.timestamps
    end
  end
end
