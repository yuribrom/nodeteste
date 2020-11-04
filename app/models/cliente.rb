require "cpf_cnpj"

class Cliente < ApplicationRecord
  has_many :contas, foreign_key: :cliente_id, dependent: :restrict_with_exception
  validates :nome, presence: true, :uniqueness => {:case_sensitive => false}
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}
  validates :cpf, presence: true, uniqueness: true
  validates :rg, presence: true, uniqueness: true
  validates_format_of :email,
                      :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i,
                      :allow_blank => false,
                      :multiline => true
  validate :check_cpf?

  def check_cpf?
    cpf = CPF.new(self.cpf)
    cpf.formatted
    cpf.stripped
    self.errors.add(:base, "Cpf inválido!") unless cpf.valid?
  end

  def self.valida(login, pass)
    usu = Cliente.find_by_email(login)
    if !usu
      return {status: "falhou", usuario: nil, msn: "Usuário inválido!"}
    else
      if usu.password == Digest::MD5.hexdigest(pass)
        return {status: "ok", usuario: {id: usu.id, nome: usu.nome, email: usu.email}, msn: "Bem Vindo #{usu.nome}!"}
      else
        return {status: "falhou", usuario: nil, msn: "Senha incorreta!"}
      end
    end
  end
end
