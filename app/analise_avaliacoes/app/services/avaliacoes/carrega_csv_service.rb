module Avaliacoes
  class CarregaCsvService
    def self.call(uploaded_file_path, produto_id)
      avaliacoes = []
      criar_ou_atualizar_produtos = produto_id.blank?

      CSV.foreach(uploaded_file_path, headers: true) do |row|
        avaliacoes << [row['avaliacoes'], row['produto_id'], row['descricao']] if row['avaliacoes']
      end

      api_url = 'http://127.0.0.1:5000'
      url = URI.parse("#{api_url}/analisar")
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url.path, { 'Content-Type' => 'application/json' })
      request.body = { avaliacoes: avaliacoes }.to_json
      
      response = http.request(request)
      response_body = JSON.parse(response.body) 

      %w[negativos positivos neutros].each do |tipo|
        sentimento = tipo.singularize

        response_body["sentimentos"][tipo].each do |avaliacao|
          id_produto = produto_id

          if criar_ou_atualizar_produtos
            produto = Produto.find_or_initialize_by(identificador: avaliacao["produto_id"])
            p "$$$$$$$$$$$$$$$$$$$$$$$$ #{avaliacao["descricao"]}"
            produto.descricao = avaliacao["descricao"] unless avaliacao["descricao"].blank?
            produto.save!
            id_produto = produto.id
          end

          cria_avaliacao(avaliacao, sentimento, id_produto)
        end
      end
    end

    private

    def self.cria_avaliacao(avaliacao, enum_sentimento, produto_id)
      Avaliacao.create(
        sentimento: enum_sentimento,
        produto_id: produto_id,
        texto: avaliacao["avaliacao"]
      )
    end
  end
end
