class Transferencia < ApplicationRecord
  attr_accessor :numero
  belongs_to :receptor, class_name: "Conta", foreign_key: "conta_id", optional: true
  belongs_to :autor, class_name: "Conta", foreign_key: "cliente_id", optional: true
  validates :cliente_id, presence: true, if: :precisa_cliente_id
  validates :conta_id, presence: true, if: :precisa_conta_id
  enum tipo: ['deposito', 'transferência', 'saque']
  validates :tipo, presence: true
  validates :valor, presence: true, numericality: {only_integer: false, :greater_than_or_equal_to => 0}
  validate :cobrar

  def self.checar_numero_conta numero
    conta = Conta.find_by_numero(numero)
    return :precisa_conta_id ? conta.id : nil
  end

  def precisa_cliente_id
    if (self.tipo == 'saque' || self.tipo == 'transferência')
      return true
    else
      return false
    end
  end


  def precisa_conta_id
    if (self.tipo == 'deposito' || self.tipo == 'transferência')
      return true
    else
      return false
    end
  end

  def cobrar
    if self.valor && self.cliente_id && self.conta_id
      tarifa = tarifa_tranferencia
      total_cobrar = tarifa + self.valor
      autor = Conta.find(self.cliente_id)
      receptor = Conta.find(self.conta_id)
      self.saldo_conta = autor.saldo
      self.tarifa = tarifa
      case self.tipo
      when 'deposito'
        receptor.saldo = receptor.saldo + self.valor
      when 'saque'
        if (autor.saldo < self.valor)
          self.errors.add(:base, "Essa operação não pode ser realizada!")
        else
          autor.saldo = autor.saldo - self.valor
        end
      else
        if (autor.saldo < total_cobrar)
          self.errors.add(:base, "Essa operação não pode ser realizada!")
        else
          autor.saldo = autor.saldo - total_cobrar
          receptor.saldo = receptor.saldo + self.valor
        end
      end
      receptor.save!
      autor.save!
    end
  end

  def tarifa_tranferencia
    tarifa = self.tipo == 'transferência' ? 10 : 0
    if (self.valor < 1000 && self.tipo == 'transferência')
      tmn = Time.now
      ds = tmn.wday
      tarifa = 7
      if (ds > 0 && ds < 6)
        if tmn.to_time.between?(Time.new(tmn.year, tmn.month, tmn.day, 9, 00, 00).to_time, Time.new(tmn.year, tmn.month, tmn.day, 18, 00, 00).to_time)
          tarifa = 5
        end
      end
    end
    return tarifa
  end

  def self.valida_transferencia(login, pass)
    usu = Cliente.find_by_email(login)
    if usu.password != Digest::MD5.hexdigest(pass)
      return {status: "falhou", msn: "Senha incorreta!"}
    else
      return {status: 'ok'}
    end
  end
end
