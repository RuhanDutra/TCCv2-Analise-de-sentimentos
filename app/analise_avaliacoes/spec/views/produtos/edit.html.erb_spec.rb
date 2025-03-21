require 'rails_helper'

RSpec.describe "produtos/edit", type: :view do
  let(:produto) {
    Produto.create!(
      identificador: "MyString",
      descricao: "MyString"
    )
  }

  before(:each) do
    assign(:produto, produto)
  end

  it "renders the edit produto form" do
    render

    assert_select "form[action=?][method=?]", produto_path(produto), "post" do

      assert_select "input[name=?]", "produto[identificador]"

      assert_select "input[name=?]", "produto[descricao]"
    end
  end
end
