module Avaliacoes
  class CarregaCsvService
    def self.call(uploaded_file_path, produto_id)
      avaliacoes = []
      
      CSV.foreach(uploaded_file_path, headers: true) do |row|
        avaliacoes << [row['avaliacoes'], row['produto_id']] if row['avaliacoes']
      end

      url = URI.parse('http://localhost:5000/analisar')
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url.path, { 'Content-Type' => 'application/json' })
      request.body = { avaliacoes: avaliacoes }.to_json
      
      response = http.request(request)
      response_body = JSON.parse(response.body)
      
      response_body["sentimentos"]["negativos"].each do |negativo|
        cria_avaliacao(negativo, "negativo", produto_id)
      end

      response_body["sentimentos"]["positivos"].each do |positivo|
        cria_avaliacao(positivo, "positivo", produto_id)
      end

      response_body["sentimentos"]["neutros"].each do |neutro|
        cria_avaliacao(neutro, "neutro", produto_id)
      end
    end

    private 

    def self.cria_avaliacao(avalicao, enum_sentimento, produto_id)
        Avaliacao.create(
          sentimento: enum_sentimento,
          produto_id: produto_id.present? ? produto_id : produto_id_definitivo,
          texto: avalicao["avaliacao"]
        )
    end
  end
end