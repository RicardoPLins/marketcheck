json.extract! supermercado, :id, :nome_mercado,:website, :localizacao, :horario_funcionamento, :created_at, :updated_at
json.url supermercado_url(supermercado, format: :json)
