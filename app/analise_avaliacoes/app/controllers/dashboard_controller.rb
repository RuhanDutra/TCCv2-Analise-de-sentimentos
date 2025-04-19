  class DashboardController < ApplicationController
    def index
      total = Avaliacao.count.to_f
  
      positivos = Avaliacao.where(sentimento: "positivo").count
      negativos = Avaliacao.where(sentimento: "negativo").count
      neutros = Avaliacao.where(sentimento: "neutro").count
  
      @grafico_barras = {
        labels: ["Positivos", "Negativos", "Neutros"],
        datasets: [{
          label: "Total de Sentimentos",
          data: [positivos, negativos, neutros],
          backgroundColor: ["#4caf50", "#f44336", "#ff9800"]
        }]
      }
  
      @grafico_pizza = {
        labels: ["Positivos", "Negativos", "Neutros"],
        datasets: [{
          label: "Percentual",
          data: [positivos, negativos, neutros],
          backgroundColor: ["#4caf50", "#f44336", "#ff9800"]
        }]
      }
      
      @grafico_produtos = Produto.joins(:avaliacoes)
                                 .group("produtos.descricao")
                                 .order("COUNT(avaliacoes.id) DESC")
                                 .limit(5)
                                 .count
  
      @grafico_produtos_dados = {
        labels: @grafico_produtos.keys,
        datasets: [{
          label: "Top 5 Produtos Mais Avaliados",
          data: @grafico_produtos.values,
          backgroundColor: "#2196f3"
        }]
      }
    end  

    def carga_produtos_avaliacoes; end
  end
