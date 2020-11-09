require 'rails_helper'

RSpec.describe Cliente, :type => :model do 
	subject {
	 	described_class.new(nome: "Yuri Estevam",
		    email: "yuribrom@gmail.com",
		    data_nascimento: DateTime.now.change(year: 1981),
		    password: Digest::MD5.hexdigest('12345'),
		    endereco: "rua 02 n°66 spl",
		    rg: 4836507,
		    cpf: '003.777.221-03')
		}

	Cliente.create({nome: 'João Pessoa', 
			   email: 'joao@gmail.com',
			   cpf: '013.909.430-03',
			   rg: 5566666, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('24680')})

  it "É válido com atributos válidos" do
    expect(subject).to be_valid
  end

  it "Não é válido sem o nome" do
    subject.nome = nil
    expect(subject).to_not be_valid
  end

   it "É inválido se o nome for duplicado" do
     objeto = Cliente.new({nome: 'João Pessoa', 
			   email: 'joaopereira@gmail.com',
			   cpf: '129.609.380-89',
			   rg: 3457609, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('12345676')})

   	 objeto.valid?
  	 expect(objeto.errors[:nome].first).to eq "já está em uso"
   end

  it "Não é válido sem o email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido com email inválido" do
    subject.email = "yuribromgmail.com"
    expect(subject).to_not be_valid
  end

  it "É inválido se o email for duplicado" do
    objeto = Cliente.new({nome: 'João Pereira', 
			   email: 'joao@gmail.com',
			   cpf: '129.609.380-89',
			   rg: 3457609, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('12345676')})

    objeto.valid?
    expect(objeto.errors[:email].first).to eq "já está em uso"
  end

  it "Não é válido sem o cpf" do
    subject.cpf = nil
    expect(subject).to_not be_valid
  end

  it "Não é válido com cpf inválido" do
    subject.cpf = "999.999.999-09"
    expect(subject).to_not be_valid
  end

  it "É inválido se o cpf for duplicado" do
    objeto = Cliente.new({nome: 'João Pereira', 
			   email: 'joaopereira@gmail.com',
			   cpf: '013.909.430-03',
			   rg: 3457609, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('12345676')})

    objeto.valid?
    expect(objeto.errors[:cpf].first).to eq "já está em uso"
  end

  it "Não é válido sem o rg" do
    subject.rg = nil
    expect(subject).to_not be_valid
  end

  it "É inválido se o rg for duplicado" do
    objeto = Cliente.new({nome: 'João Pereira', 
			   email: 'joao@gmail.com',
			   cpf: '129.609.380-89',
			   rg: 5566666, endereco: 'rua 02 número 05 SPL',
			   data_nascimento: '1986-02-12', 
			   password: Digest::MD5.hexdigest('12345676')})

    objeto.valid?
    expect(objeto.errors[:rg].first).to eq "já está em uso"
  end

  it "É válido sem o data de nascimento" do
    subject.data_nascimento = nil
    expect(subject).to be_valid
  end

  it "É válido sem o endereco" do
  	subject.endereco = nil
    expect(subject).to be_valid
  end

end