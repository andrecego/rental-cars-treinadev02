class Subsidiary < ApplicationRecord
  validates :cnpj, format: {with: /\d{2}[.]\d{3}[.]\d{3}[\/]\d{4}[-]\d{2}/,
                            message: 'CNPJ inválido, formato: xx.xxx.xxx/xxxx-xx'}
  validates :cnpj, uniqueness: { message: 'CNPJ já cadastrado' }
  has_many :cars, dependent: :restrict_with_error #{ message: 'Não deu'}
end