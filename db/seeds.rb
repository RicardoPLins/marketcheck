puts "Cadastrando produtos"
Produto.create([
  { nome: 'Arroz Integral', descricao: 'Arroz integral de alta qualidade', categoria: 'Alimentos', marca: 'Marca A', preco: 6.50, unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.5, imagem: 'imagem_arroz.jpg', link: 'http://example.com/produto1' },
  { nome: 'Feijão Preto', descricao: 'Feijão preto selecionado', categoria: 'Alimentos', marca: 'Marca B', preco: 5.00, unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.2, imagem: 'imagem_feijao.jpg', link: 'http://example.com/produto2' },
  { nome: 'Macarrão Espaguete', descricao: 'Macarrão tipo espaguete', categoria: 'Alimentos', marca: 'Marca C', preco: 3.20, unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.7, imagem: 'imagem_macarrao.jpg', link: 'http://example.com/produto3' },
  { nome: 'Açúcar Cristal', descricao: 'Açúcar cristal refinado', categoria: 'Alimentos', marca: 'Marca D', preco: 2.50, unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.3, imagem: 'imagem_acucar.jpg', link: 'http://example.com/produto4' },
  { nome: 'Sal Refinado', descricao: 'Sal refinado iodado', categoria: 'Alimentos', marca: 'Marca E', preco: 1.00, unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.8, imagem: 'imagem_sal.jpg', link: 'http://example.com/produto5' },
  { nome: 'Café Torrado e Moído', descricao: 'Café torrado e moído de alta qualidade', categoria: 'Bebidas', marca: 'Marca F', preco: 9.00, unidade_de_medida: '500g', disponibilidade: true, avaliacoes: 4.6, imagem: 'imagem_cafe.jpg', link: 'http://example.com/produto6' },
  { nome: 'Óleo de Soja', descricao: 'Óleo de soja refinado', categoria: 'Alimentos', marca: 'Marca G', preco: 7.00, unidade_de_medida: 'litro', disponibilidade: true, avaliacoes: 4.4, imagem: 'imagem_oleo.jpg', link: 'http://example.com/produto7' },
  { nome: 'Leite Integral', descricao: 'Leite integral pasteurizado', categoria: 'Bebidas', marca: 'Marca H', preco: 4.00, unidade_de_medida: 'litro', disponibilidade: true, avaliacoes: 4.5, imagem: 'imagem_leite.jpg', link: 'http://example.com/produto8' },
  { nome: 'Farinha de Trigo', descricao: 'Farinha de trigo tipo 1', categoria: 'Alimentos', marca: 'Marca I', preco: 3.80, unidade_de_medida: 'kg', disponibilidade: true, avaliacoes: 4.7, imagem: 'imagem_farinha.jpg', link: 'http://example.com/produto9', nome_mercado:"" }
  ]
  )