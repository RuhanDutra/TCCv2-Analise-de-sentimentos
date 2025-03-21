require 'rails_helper'

RSpec.describe "avaliacoes/show", type: :view do
  before(:each) do
    assign(:avaliacao, Avaliacao.create!(
      texto: "Texto",
      sentimento: 2,
      produto: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Texto/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
