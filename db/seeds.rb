puts "Cadastrando produtos"

produtos = [
  { nome: 'Arroz Integral', descricao: 'Arroz integral de alta qualidade', categoria: 'Alimentos', marca: 'Marca A', unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.5, imagem: 'imagem_arroz.jpg' },
  { nome: 'Feijão Preto', descricao: 'Feijão preto selecionado', categoria: 'Alimentos', marca: 'Marca B', unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.2, imagem: 'imagem_feijao.jpg' },
  { nome: 'Macarrão Espaguete', descricao: 'Macarrão tipo espaguete', categoria: 'Alimentos', marca: 'Marca C', unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.7, imagem: 'imagem_macarrao.jpg' },
  { nome: 'Açúcar Cristal', descricao: 'Açúcar cristal refinado', categoria: 'Alimentos', marca: 'Marca D', unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.3, imagem: 'imagem_acucar.jpg' },
  { nome: 'Sal Refinado', descricao: 'Sal refinado iodado', categoria: 'Alimentos', marca: 'Marca E', unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.8, imagem: 'imagem_sal.jpg' },
  { nome: 'Café Torrado e Moído', descricao: 'Café torrado e moído de alta qualidade', categoria: 'Bebidas', marca: 'Marca F', unidade_de_medida: '500g', disponibilidade: true, avaliacoes: 4.6, imagem: 'imagem_cafe.jpg' },
  { nome: 'Óleo de Soja', descricao: 'Óleo de soja refinado', categoria: 'Alimentos', marca: 'Marca G', unidade_de_medida: 'litro', disponibilidade: true, avaliacoes: 4.4, imagem: 'imagem_oleo.jpg' },
  { nome: 'Leite Integral', descricao: 'Leite integral pasteurizado', categoria: 'Bebidas', marca: 'Marca H', unidade_de_medida: 'litro', disponibilidade: true, avaliacoes: 4.5, imagem: 'imagem_leite.jpg' },
  { nome: 'Farinha de Trigo', descricao: 'Farinha de trigo tipo 1', categoria: 'Alimentos', marca: 'Marca I', unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.7, imagem: 'imagem_farinha.jpg' }
]

# Produtos com preços modificados para cada mercado
produtos_mercados = [
  { nome: 'Arroz Integral', preco: 6.00, nome_mercado: 'BemMais' },
  { nome: 'Arroz Integral', preco: 7.50, nome_mercado: 'Carrefour' },
  { nome: 'Arroz Integral', preco: 6.75, nome_mercado: 'Aquarius' },
  { nome: 'Feijão Preto', preco: 5.50, nome_mercado: 'BemMais' },
  { nome: 'Feijão Preto', preco: 4.50, nome_mercado: 'Carrefour' },
  { nome: 'Feijão Preto', preco: 5.00, nome_mercado: 'Aquarius' },
  { nome: 'Macarrão Espaguete', preco: 3.00, nome_mercado: 'BemMais' },
  { nome: 'Macarrão Espaguete', preco: 3.50, nome_mercado: 'Carrefour' },
  { nome: 'Macarrão Espaguete', preco: 2.75, nome_mercado: 'Aquarius' },
  { nome: 'Açúcar Cristal', preco: 2.30, nome_mercado: 'BemMais' },
  { nome: 'Açúcar Cristal', preco: 2.70, nome_mercado: 'Carrefour' },
  { nome: 'Açúcar Cristal', preco: 2.50, nome_mercado: 'Aquarius' },
  { nome: 'Sal Refinado', preco: 0.90, nome_mercado: 'BemMais' },
  { nome: 'Sal Refinado', preco: 1.10, nome_mercado: 'Carrefour' },
  { nome: 'Sal Refinado', preco: 1.00, nome_mercado: 'Aquarius' },
  { nome: 'Café Torrado e Moído', preco: 8.50, nome_mercado: 'BemMais' },
  { nome: 'Café Torrado e Moído', preco: 9.00, nome_mercado: 'Carrefour' },
  { nome: 'Café Torrado e Moído', preco: 9.50, nome_mercado: 'Aquarius' },
  { nome: 'Óleo de Soja', preco: 7.50, nome_mercado: 'BemMais' },
  { nome: 'Óleo de Soja', preco: 7.00, nome_mercado: 'Carrefour' },
  { nome: 'Óleo de Soja', preco: 7.00, nome_mercado: 'Aquarius' },
  { nome: 'Leite Integral', preco: 4.00, nome_mercado: 'BemMais' },
  { nome: 'Leite Integral', preco: 4.50, nome_mercado: 'Carrefour' },
  { nome: 'Leite Integral', preco: 4.00, nome_mercado: 'Aquarius' },
  { nome: 'Farinha de Trigo', preco: 3.75, nome_mercado: 'BemMais' },
  { nome: 'Farinha de Trigo', preco: 3.50, nome_mercado: 'Carrefour' },
  { nome: 'Farinha de Trigo', preco: 4.00, nome_mercado: 'Aquarius' }
]

# Cadastrando produtos com preços modificados
produtos_mercados.each do |produto_mercado|
  produto_base = produtos.find { |p| p[:nome] == produto_mercado[:nome] }
  Produto.create(produto_base.merge(preco: produto_mercado[:preco], nome_mercado: produto_mercado[:nome_mercado]))
end
