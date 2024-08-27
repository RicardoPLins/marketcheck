json.extract! produto, :id, :nome, :descricao, :categoria, :marca, :preco, :unidade_de_medida, :disponibilidade, :avaliacoes, :imagem, :nome_mercado, :supermercado_id, :created_at, :updated_at
json.url produto_url(produto, format: :json)
