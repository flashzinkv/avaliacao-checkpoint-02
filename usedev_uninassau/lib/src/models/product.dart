class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.colors = const ['Bege', 'Branca', 'Cinza'],
    this.sizes = const ['P', 'M', 'G', 'GG'],
    this.quantities = const ['1', '2', '3', '4', '5'],
  });

  final String id;
  final String name;
  final String description;
  final String price;
  final String imagePath;
  final List<String> colors;
  final List<String> sizes;
  final List<String> quantities;
}

/// Catálogo de produtos da loja.
///
/// Para adicionar um produto:
/// 1. Exporte a imagem do Figma em PNG.
/// 2. Salve em `assets/products/` (ex: `camiseta_capy.png`).
/// 3. Cadastre o produto abaixo com o mesmo caminho em [imagePath].
const productCatalog = <Product>[
  Product(
    id: '1',
    name: 'Camisa do Ben 10',
    description: 'Camiseta 100% algodão.',
    price: '59,90',
    imagePath: 'assets/products/ben10.png',
  ),
  Product(
    id: '2',
    name: 'Camisa do He Man',
    description: 'Camiseta 100% algodão.',
    price: '89,90',
    imagePath: 'assets/products/heman.png',
  ),
  Product(
    id: '3',
    name: 'Cueca da Marvel',
    description: 'Cueca 100% algodão.',
    price: '26,90',
    imagePath: 'assets/products/marvel.png',
  ),
  Product(
    id: '4',
    name: 'Camisa do Maior time do Brasil',
    description: 'Camiseta 100% algodão.',
    price: '103,90',
    imagePath: 'assets/products/parmalat.png',
  ),
];

Product? productById(String id) {
  for (final product in productCatalog) {
    if (product.id == id) return product;
  }
  return null;
}
