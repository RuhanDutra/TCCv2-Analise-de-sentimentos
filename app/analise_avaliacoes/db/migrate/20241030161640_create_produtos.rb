class CreateProdutos < ActiveRecord::Migration[7.2]
  def change
    create_table :produtos do |t|
      t.string :identificador
      t.string :descricao

      t.timestamps
    end
  end
end
