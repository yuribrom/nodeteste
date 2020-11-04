class TransferenciasController < ApplicationController
  before_action :set_transferencia, only: [:show, :edit, :update, :destroy]

  # GET /transferencias
  # GET /transferencias.json
  def index
    @transferencias = Transferencia.all
  end

  # GET /transferencias/1
  # GET /transferencias/1.json
  def show
  end

  # GET /transferencias/new
  def new
    @transferencia = Transferencia.new
    @transferencia.tipo = params[:tipo]
    set_conta_cliente(params[:cliente_id])
  end

  # POST /transferencias
  # POST /transferencias.json
  def create
    @transferencia = Transferencia.new(transferencia_params)
    @transferencia.valor = dinheiro_fomatado params[:transferencia][:valor]
    set_conta_cliente(@transferencia.cliente_id)
    @transferencia.conta_id = @transferencia.tipo == 'saque' ? @conta_autor.id : Transferencia.checar_numero_conta(params[:transferencia][:numero])
    case @transferencia.tipo
    when 'transferência'
      retorno = Transferencia.valida_transferencia(session[:usuario_email], params[:usu][:senha])
      if retorno[:status] == 'falhou'
        respond_to do |format|
          flash[:alert] = retorno[:msn]
          format.html { render :new }
        end
      else
        salvar @transferencia, @cliente_autor
      end
    else
      salvar @transferencia, @cliente_autor
    end
  end

  # PATCH/PUT /transferencias/1
  # PATCH/PUT /transferencias/1.json

  private

  def set_conta_cliente(conta_id)
    @conta_autor = Conta.find(conta_id)
    @cliente_autor = Cliente.find(@conta_autor.cliente_id)
  end

  def salvar transferencia, cliente_autor
    respond_to do |format|
      if transferencia.save
        format.html { redirect_to cliente_autor, notice: transferencia.tipo + ' realizada com sucesso.' }
        format.json { render :show, status: :created, location: cliente_autor }
      else
        format.html { render :new }
        format.json { render json: transferencia.errors, status: :unprocessable_entity }
      end
    end
  end

  def dinheiro_fomatado valor
    retorno = nil
    unless valor.blank?
      retorno = valor.gsub('.', '')
      retorno = retorno.gsub(',', '.')
    end
    return retorno
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_transferencia
    @transferencia = Transferencia.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transferencia_params
    params.require(:transferencia).permit(:conta_id, :valor, :tipo, :cliente_id, :saldo_conta, :tarifa)
  end
end
