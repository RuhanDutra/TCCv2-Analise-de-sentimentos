module Produtos
  class CarregaCsvService
    def self.call(uploaded_file_path)
      produtos = []
      
      CSV.foreach(uploaded_file_path, headers: true) do |row|
        next if row['produto_id'].blank? || row['descricao'].blank?

        produtos << { produto_id: row['produto_id'], descricao: row['descricao'] }
      end

      produtos.each do |produto|
        Produto.find_or_create(
          produto_id: produto[:produto_id],
          descricao: produto[:descricao]
        )
      end
    end
  end
end