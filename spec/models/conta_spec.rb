require 'rails_helper'

RSpec.describe Conta, :type => :model do 
	cliente = Cliente.create({nome: 'Amorim da silva', 
			   email: 'amorim@gmail.com',
			   cpf: '822.605.620-94',
			   rg: 5566666, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('24680')})

  subject { 
    described_class.new(
    numero: '12345', 
    data_abertura: DateTime.now, 
    data_encerramento: nil, 
    tipo: 0, 
    saldo: 3000.0,
    cliente_id: 1)
}
Conta.create({
    numero: '123456', 
    data_abertura: '2020-02-12', 
    data_encerramento: nil, 
    tipo: 1, 
    saldo: 3000.0,
    cliente_id: 1})

  it "É válido com atributos válidos" do
    expect(subject).to be_valid
  end

  it "Não é válido sem o número" do
    subject.numero = nil
    expect(subject).to_not be_valid
  end

   it "É inválido se o numero for duplicado" do
     objeto = Conta.new({
    numero: '123456', 
    data_abertura: '2020-02-12', 
    data_encerramento: nil, 
    tipo: 1, 
    saldo: 3000.0,
    cliente_id: 1})

   	 objeto.valid?
  	 expect(objeto.errors[:numero].first).to eq "já está em uso"
   end

  it "Não é válido sem o data de abertura" do
    subject.data_abertura = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido com saldo inválido" do
    subject.saldo = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido com saldo < 0" do
    subject.saldo = -100
    expect(subject).to_not be_valid
  end

  it "Não é válido sem o cliente" do
    subject.cliente_id = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido sem o tipo" do
    subject.tipo = nil
    expect(subject).to_not be_valid
  end

  it "É válido sem data_encerramento" do
  	subject.data_encerramento = nil
    expect(subject).to be_valid
  end

end