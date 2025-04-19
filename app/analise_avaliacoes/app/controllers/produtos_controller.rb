  class ProdutosController < ApplicationController
    before_action :set_produto, only: %i[ show edit update destroy ]
  
    # GET /produtos
    def index
      @q = Produto.ransack(params[:q])
      @pagy, @produtos = pagy(
        @q.result, items: 10 
      )
    end
  
    def show
      @produto = Produto.find(params[:id])
    
      avaliacoes = @produto.avaliacoes
      total = avaliacoes.count.to_f
    
      positivos = avaliacoes.where(sentimento: "positivo").count
      negativos = avaliacoes.where(sentimento: "negativo").count
      neutros   = avaliacoes.where(sentimento: "neutro").count
    
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
    
      positivas = avaliacoes.where(sentimento: "positivo").pluck(:texto)
      negativas = avaliacoes.where(sentimento: "negativo").pluck(:texto)
    
      @elogios = contar_principais_palavras(positivas)
      @criticas = contar_principais_palavras(negativas)      
    
      @grafico_elogios = {
        labels: @elogios.keys,
        datasets: [{
          label: "Elogios mais citados",
          data: @elogios.values,
          backgroundColor: "#4caf50"
        }]
      }
    
      @grafico_criticas = {
        labels: @criticas.keys,
        datasets: [{
          label: "Críticas mais citadas",
          data: @criticas.values,
          backgroundColor: "#f44336"
        }]
      }
    end    
  
    def new
      @produto = Produto.new
    end
  
    def edit; end
  
    def create
      @produto = Produto.new(produto_params)
  
      if @produto.save
        redirect_to @produto
        flash[:success] = t("#{}.created") 
      else
        render :new, status: :unprocessable_entity
        flash[:error] = t("#{}.no_created")
      end
    end
  
    def update
      if @produto.update(produto_params)
        redirect_to @produto
        flash[:success] = t("#{}.updated")  
      else
        render :edit, status: :unprocessable_entity
        flash[:error] = t("#{}.no_updated")
      end
    end
  
    def destroy
      if  @produto.destroy!
        redirect_to produtos_url
        flash[:success] = t("#{}.deleted")   
      else 
        redirect_to @produto
        flash[:error] = t("#{}.no_deleted")   
      end
    end
    
    def carrega_avaliacoes
      @produto_id = params[:produto_id]
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_produto
        @produto = Produto.find(params[:id])
      end
  
      def produto_params
        params.require(:produto).permit(:identificador, :descricao)
      end
    
      def contar_principais_palavras(avaliacoes)
        stopwords = %w[o a os as de do da dos das e é foi foi-se que com para um uma em no na nos nas por se muito produto gostei]
        frequencia = Hash.new(0)
      
        avaliacoes.each do |texto|
          palavras = texto.downcase.scan(/\b[^\d\W]{3,}\b/) - stopwords
          palavra_mais_forte = palavras.tally.max_by { |_, v| v }&.first
          frequencia[palavra_mais_forte] += 1 if palavra_mais_forte
        end
      
        frequencia.sort_by { |_, count| -count }.first(10).to_h
      end
      
  end
  