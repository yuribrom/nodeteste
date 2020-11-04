 # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
 clientes = Cliente.create([{nome: 'Yuri Estevam Brom Vieira', email: 'yuribrom@gmail.com', cpf: '355.648.920-11', rg: '4565687', endereco: 'rua 03 número 04 SPL', data_nascimento: '1986-09-10', password: Digest::MD5.hexdigest('12345')}, {nome: 'João Pessoa', email: 'joao@gmail.com', cpf: '013.909.430-03', rg: '5566666', endereco: 'rua 02 número 05 SPL', data_nascimento: '1986-02-12', password: Digest::MD5.hexdigest('24680')}])
 Conta.create({numero: '12345', data_abertura: '2020-02-12', data_encerramento: nil, tipo: 0, saldo: 3000.0, cliente_id: clientes.first.id})
 Conta.create({numero: '23456', data_abertura: '2020-02-12', data_encerramento: nil, tipo: 1, saldo: 4000.0, cliente_id: clientes.last.id})