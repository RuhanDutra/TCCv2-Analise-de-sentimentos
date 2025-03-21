require 'rails_helper'

RSpec.describe "produtos/show", type: :view do
  before(:each) do
    assign(:produto, Produto.create!(
      identificador: "Identificador",
      descricao: "Descricao"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identificador/)
    expect(rendered).to match(/Descricao/)
  end
end
