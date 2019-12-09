class Client < ApplicationRecord
  validates :name, :document, :email, presence: { message: 'Todos campos precisam ser preenchidos' }
  validates :document, format: { with: /\d{3}[.]\d{3}[.]\d{3}[-]\d{2}/,
                             message: 'CPF está no formato inválido, formato: xxx.xxx.xxx-xx' }
  validates :document, uniqueness: { message: 'CPF já registrado' }

  def uniq_name
    name + ' (' + document + ')'
  end
end