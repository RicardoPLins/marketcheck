json.extract! supermercado, :id, :nome, :endereco, :horario_de_funcionamento, :created_at, :updated_at, :localizacao
json.url supermercado_url(supermercado, format: :json)
