json.extract! produto, :id, :nome_produto, :link_to_item, :image_url, :preco, :categoria, :created_at, :updated_at
json.url produto_url(produto, format: :json)
