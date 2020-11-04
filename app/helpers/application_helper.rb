module ApplicationHelper
  def imprimi_data(data)
    return l data, format: :default unless data.blank?
    return nil
  end

  def imprimi_data_hora(data_hora)
    return l data_hora, format: :default unless data_hora.blank?
    return nil
  end

  def formata_dinheiro(valor)
    return number_to_currency(valor)  unless valor.blank?
    return nil
  end
end
