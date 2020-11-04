class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :edit, :update, :destroy]

  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)
    @cliente.password = Digest::MD5.hexdigest(@cliente.password)
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Cliente criado com sucesso.' }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1
  # PATCH/PUT /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)
        format.html { redirect_to @cliente, notice: 'Cliente atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  def extrato
    @conta = Conta.find(params[:cliente_id])
    @cliente = Cliente.find(@conta.cliente_id)
    cond = []
    if params[:data]
      cond << "created_at >= '#{params[:data][:inicio]}'" unless params[:data][:inicio].blank?
      cond << "created_at <= '#{params[:data][:fim]}'" unless params[:data][:fim].blank?
    end
    cond << "cliente_id = #{@conta.id}" unless @conta.nil?
    @transferencias = Transferencia.where(cond.join(' AND '))
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cliente_params
    params.require(:cliente).permit(:nome, :email, :cpf, :rg, :endereco, :data_nascimento, :password)
  end
end
