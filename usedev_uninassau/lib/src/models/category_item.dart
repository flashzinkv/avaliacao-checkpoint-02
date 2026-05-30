class CategoryItem {
  const CategoryItem({
    required this.name,
    required this.imagePath,
  });

  final String name;
  final String imagePath;
}

const defaultCategories = [
  CategoryItem(
    name: 'Roupas',
    imagePath: 'assets/categories/roupas.png',
  ),
  CategoryItem(
    name: 'Decoração',
    imagePath: 'assets/categories/decoração.png',
  ),
  CategoryItem(
    name: 'Canecas',
    imagePath: 'assets/categories/canecas.png',
  ),
  CategoryItem(
    name: 'Acessórios',
    imagePath: 'assets/categories/acessórios.png',
  ),
];
