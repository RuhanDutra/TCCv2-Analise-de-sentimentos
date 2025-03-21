require 'rails_helper'

RSpec.describe "produtos/index", type: :view do
  before(:each) do
    assign(:produtos, [
      Produto.create!(
        identificador: "Identificador",
        descricao: "Descricao"
      ),
      Produto.create!(
        identificador: "Identificador",
        descricao: "Descricao"
      )
    ])
  end

  it "renders a list of produtos" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Identificador".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Descricao".to_s), count: 2
  end
end
