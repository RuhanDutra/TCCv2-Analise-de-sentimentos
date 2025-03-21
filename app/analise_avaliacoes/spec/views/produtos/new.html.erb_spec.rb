require 'rails_helper'

RSpec.describe "produtos/new", type: :view do
  before(:each) do
    assign(:produto, Produto.new(
      identificador: "MyString",
      descricao: "MyString"
    ))
  end

  it "renders new produto form" do
    render

    assert_select "form[action=?][method=?]", produtos_path, "post" do

      assert_select "input[name=?]", "produto[identificador]"

      assert_select "input[name=?]", "produto[descricao]"
    end
  end
end
