  require 'csv'
  require 'net/http'
  require 'json'

  class AvaliacoesController < ApplicationController
    before_action :set_avaliacao, only: %i[ show edit update destroy ]
  
    # GET /avaliacoes
    def index
      @q = Avaliacao.ransack(params[:q])
      @pagy, @avaliacoes = pagy(
        @q.result, items: 10 
      )
    end
  
    def show; end
  
    def new
      @avaliacao = Avaliacao.new
    end
  
    def edit; end
  
    def create
      @avaliacao = Avaliacao.new(avaliacao_params)
  
      if @avaliacao.save
        redirect_to @avaliacao
        flash[:success] = t("#{}.created") 
      else
        render :new, status: :unprocessable_entity
        flash[:error] = t("#{}.no_created")
      end
    end
  
    def update
      if @avaliacao.update(avaliacao_params)
        redirect_to @avaliacao
        flash[:success] = t("#{}.updated")  
      else
        render :edit, status: :unprocessable_entity
        flash[:error] = t("#{}.no_updated")
      end
    end
  
    def destroy
      if  @avaliacao.destroy!
        redirect_to avaliacoes_url
        flash[:success] = t("#{}.deleted")   
      else 
        redirect_to @avaliacao
        flash[:error] = t("#{}.no_deleted")   
      end
    end

    def avaliacoes_por_csv
      produto_id = params[:produto_id]
      produtos_e_avaliacoes = params[:produtos_e_avaliacoes] == "true" ? true : false
      uploaded_file = params[:file]
  
      if produto_id.nil? && !produtos_e_avaliacoes
        flash[:error] = "Produto não encontrado."
        redirect_to request.referer and return
      end
  
      if uploaded_file.nil?
        flash[:error] = "Por favor, selecione um arquivo CSV para enviar."
        redirect_to request.referer and return
      end
  
      Avaliacoes::CarregaCsvService.call(uploaded_file.path, produto_id);

      flash[:success] = "Arquivo CSV processado com sucesso para o produto ##{produto_id}!"
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_avaliacao
        @avaliacao = Avaliacao.find(params[:id])
      end
  
      def avaliacao_params
        params.require(:avaliacao).permit(:texto, :sentimento, :produto_id)
      end
  end
  