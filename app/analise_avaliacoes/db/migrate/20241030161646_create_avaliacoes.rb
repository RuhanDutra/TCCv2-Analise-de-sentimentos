class CreateAvaliacoes < ActiveRecord::Migration[7.2]
  def change
    create_table :avaliacoes do |t|
      t.string :texto
      t.integer :sentimento
      t.references :produto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
