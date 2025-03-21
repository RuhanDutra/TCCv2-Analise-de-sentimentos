require 'rails_helper'

RSpec.describe "avaliacoes/edit", type: :view do
  let(:avaliacao) {
    Avaliacao.create!(
      texto: "MyString",
      sentimento: 1,
      produto: nil
    )
  }

  before(:each) do
    assign(:avaliacao, avaliacao)
  end

  it "renders the edit avaliacao form" do
    render

    assert_select "form[action=?][method=?]", avaliacao_path(avaliacao), "post" do

      assert_select "input[name=?]", "avaliacao[texto]"

      assert_select "input[name=?]", "avaliacao[sentimento]"

      assert_select "input[name=?]", "avaliacao[produto_id]"
    end
  end
end
