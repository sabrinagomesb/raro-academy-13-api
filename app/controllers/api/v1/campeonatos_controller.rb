class Api::V1::CampeonatosController < Api::V1::ApiController
  before_action :fetch_campeonato, only: [:show, :ranking]

  def index
    if params[:somente_ativos]
      campeonatos = current_usuario.campeonatos.ativos
    else
      campeonatos = current_usuario.campeonatos.all
    end

    render json: campeonatos
  end

  def create
    cliente = ApiFutebolService.new
    cliente.atualiza_campeonatos!

    head :no_content
  end

  def show
    render json: @campeonato
  end

  def ranking
    render json: @campeonato.ranking
  end

  private

  def fetch_campeonato
    if params[:id]
      @campeonato = current_usuario.campeonatos.find(params[:id])
    elsif params[:campeonato_id]
      @campeonato = current_usuario.campeonatos.find(params[:campeonato_id])
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Campeonato não encontrado" }, status: :not_found
  end
end
