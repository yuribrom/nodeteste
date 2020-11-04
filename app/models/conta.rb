class Conta < ApplicationRecord
  has_one :cliente, dependent: :restrict_with_exception
  has_many :transferencias, dependent: :restrict_with_exception
  enum tipo: ['corrente', 'poupança']
  validates :numero, presence: true, uniqueness: true
  validates :data_abertura, presence: true
  validates :tipo, presence: true
  validates :cliente_id, presence: true
  validates :saldo, presence: true, numericality: {only_integer: false, :greater_than_or_equal_to => 0}
end
