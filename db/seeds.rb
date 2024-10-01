# Função para gerar uma indicação aleatória de localização no mercado
def gerar_indicacao_mercado
  fileira = rand(1..10) # Gera um número de fileira aleatório entre 1 e 10
  lado = ['Lado Direito', 'Lado Esquerdo'].sample # Aleatoriamente escolhe o lado
  "Fileira #{fileira}, #{lado}"
end

# Atualiza todos os produtos com uma indicação aleatória de localização no mercado
Produto.find_each do |produto|
  produto.update(indicacao_no_mercado: gerar_indicacao_mercado)
end