require 'rails_helper'

RSpec.describe "avaliacoes/new", type: :view do
  before(:each) do
    assign(:avaliacao, Avaliacao.new(
      texto: "MyString",
      sentimento: 1,
      produto: nil
    ))
  end

  it "renders new avaliacao form" do
    render

    assert_select "form[action=?][method=?]", avaliacoes_path, "post" do

      assert_select "input[name=?]", "avaliacao[texto]"

      assert_select "input[name=?]", "avaliacao[sentimento]"

      assert_select "input[name=?]", "avaliacao[produto_id]"
    end
  end
end
