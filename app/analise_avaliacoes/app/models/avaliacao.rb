class Avaliacao < ApplicationRecord
  belongs_to :produto

  enum sentimento: {
    positivo: 0,
    negativo: 1,
    neutro: 2
  }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "produto_id", "sentimento", "texto", "updated_at"]
  end
end
