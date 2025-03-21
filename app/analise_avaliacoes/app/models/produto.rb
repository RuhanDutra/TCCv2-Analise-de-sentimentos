class Produto < ApplicationRecord
  has_many :avaliacoes
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "descricao", "id", "identificador", "updated_at"]
  end
end
