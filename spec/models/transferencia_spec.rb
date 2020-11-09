require 'rails_helper'

RSpec.describe Transferencia, :type => :model do 
	cliente = Cliente.create({nome: 'Amorim da silva', 
			   email: 'amorim@gmail.com',
			   cpf: '822.605.620-94',
			   rg: 7679900, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('24680')})

  conta = Conta.create({
    numero: '7980008', 
    data_abertura: '2020-02-12', 
    data_encerramento: nil, 
    tipo: 1, 
    saldo: 3000.0,
    cliente_id: 1})

  subject { 
    described_class.new(
    tipo: "transferência", 
    valor: 50,
    cliente_id: 1,
    conta_id: 1,
    numero: '123456',
    saldo_conta: nil,
    tarifa: nil)
  }

  it "É válido com atributos válidos" do
    expect(subject).to be_valid
  end

  it "Não é válido sem o tipo" do
    subject.tipo = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido sem valor" do
    subject.valor = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido com valor < 0" do
    subject.valor = -100
    expect(subject).to_not be_valid
  end

  it "Não é válido movimentação que fara a conta ficar com saldo negativo" do
    movimentacao = Transferencia.create(
    tipo: "transferência", 
    valor: 500000.0,
    cliente_id: 1,
    conta_id: 1,
    numero: '123456')
    expect(movimentacao.errors[:base].first).to eq "Essa operação não pode ser realizada!"
  end

  it "Não é válido Transferencia sem o cliente" do
    subject.cliente_id = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido Saque sem o cliente" do
    subject.tipo = 'saque'
    subject.cliente_id = nil
    expect(subject).to_not be_valid
  end

  it "É válido Deposito sem o cliente" do
    subject.tipo = 'deposito'
    subject.cliente_id = nil
    expect(subject).to be_valid
  end

  it "Não é válido Transferencia sem o conta" do
    subject.conta_id = nil
    expect(subject).to_not be_valid
  end

  it "É válido Saque sem o conta" do
    subject.tipo = 'saque'
    subject.conta_id = nil
    expect(subject).to be_valid
  end

  it "Não é válido Transferencia sem autentificação" do

  cliente = Cliente.create({nome: 'Amorim Pereira da silva', 
         email: 'amorimpereirasilva@gmail.com',
         cpf: '260.519.330-69',
         rg: 67587698, endereco: 'rua 02 número 05 SPL',
         data_nascimento: '1986-02-12', 
         password: Digest::MD5.hexdigest('24680')})

  conta = Conta.create({
    numero: '56873266', 
    data_abertura: '2020-02-12', 
    data_encerramento: nil, 
    tipo: 1, 
    saldo: 3000.0,
    cliente_id: 1})
    cliente.save!
    conta.save!
    retorno = Transferencia.valida_transferencia(cliente.email, '7669870') 
    expect(retorno[:msn]).to eq 'Senha incorreta!'
  end

end