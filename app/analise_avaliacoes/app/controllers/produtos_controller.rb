  class ProdutosController < ApplicationController
    before_action :set_produto, only: %i[ show edit update destroy ]
  
    # GET /produtos
    def index
      @q = Produto.ransack(params[:q])
      @pagy, @produtos = pagy(
        @q.result, items: 10 
      )
    end
  
    def show; end
  
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
  end
  