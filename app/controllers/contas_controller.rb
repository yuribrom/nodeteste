class ContasController < ApplicationController
  before_action :set_conta, only: [:show, :edit, :update, :destroy]

  # GET /contas
  # GET /contas.json
  def index
    @conta = Conta.all
  end

  # GET /contas/1
  # GET /contas/1.json
  def show
  end

  # GET /contas/new
  def new
    @conta = Conta.new
    @cliente = Cliente.find(params[:cliente_id])
  end

  # GET /contas/1/edit
  def edit
  end

  # POST /contas
  # POST /contas.json
  def create
    @conta = Conta.new(conta_params)
    @cliente = Cliente.find(@conta.cliente_id)
    respond_to do |format|
      if @conta.save
        format.html { redirect_to @cliente, notice: 'conta criada com sucesso.' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contas/1
  # PATCH/PUT /contas/1.json
  def update
    respond_to do |format|
      if @conta.update(conta_params)
        format.html { redirect_to @conta, notice: 'conta atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @conta }
      else
        format.html { render :edit }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    format.html { redirect_to @conta, alert: 'Conta não pode ser excluída.' }
    format.json { render :show, status: :ok, location: @conta }
  end

  private

  def dinheiro_fomatado valor
    return valor.gsub('.', '') .gsub(',', '.').to_f unless valor.blank?
    return nil
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_conta
    @conta = Conta.find(params[:id])
    @cliente = Cliente.find(@conta.cliente_id)
  end

  def confirma_cliente_id id
    if id != session[:usuario_id]
      render cliente_path(id: id)
    end
  end

  # Only allow a list of trusted parameters through.
  def conta_params
    params[:conta][:saldo] = dinheiro_fomatado(params[:conta][:saldo])
    params.require(:conta).permit(:numero, :saldo, :data_abertura, :tipo, :data_encerramento, :cliente_id)
  end
end
