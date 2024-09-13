json.extract! produto, :id, :nome_produto, :link_to_item, :image_url, :preco, :categoria, :created_at, :updated_at
json.url produto_url(produto, format: :json)

# Acessar o supermercado associado através do relacionamento ProdutosPreco
json.supermercado do
  # Verifica se há um registro em ProdutosPreco e, em caso afirmativo, acessa o supermercado
  if produto.produtos_precos.first
    json.extract! produto.produtos_precos.first.supermercado, :id, :nome_mercado, :localizacao
    json.preco produto.produtos_precos.first.preco # Adicionar o preço do produto no supermercado
  end
end
