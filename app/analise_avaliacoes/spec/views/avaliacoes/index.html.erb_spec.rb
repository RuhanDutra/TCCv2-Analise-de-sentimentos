require 'rails_helper'

RSpec.describe "avaliacoes/index", type: :view do
  before(:each) do
    assign(:avaliacoes, [
      Avaliacao.create!(
        texto: "Texto",
        sentimento: 2,
        produto: nil
      ),
      Avaliacao.create!(
        texto: "Texto",
        sentimento: 2,
        produto: nil
      )
    ])
  end

  it "renders a list of avaliacoes" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Texto".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
