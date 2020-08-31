class Product {
  String imageUrl;
  String title;
  String brand;
  String producttyp;
  String description;
  double price;

  Product(
      {this.imageUrl,
      this.title,
      this.brand,
      this.producttyp,
      this.description,
      this.price});
}

List<Product> suggestions = [
  Product(
      imageUrl: 'assets/images/iphone11.png',
      title: 'iPhone 11',
      brand: 'Apple',
      producttyp: 'Smartphone',
      description: 'Top Smartphone 2019 from Apple',
      price: 749.99),
  Product(
      imageUrl: 'assets/images/note20ultra.png',
      title: 'Note 20 Ultra',
      brand: 'Samsung',
      producttyp: 'Smartphone',
      description: 'Top Smartphone 2020 from 2020',
      price: 1299.99),
  Product(
      imageUrl: 'assets/images/iphone11.png',
      title: 'iPhone 11',
      brand: 'Apple',
      producttyp: 'Smartphone',
      description: 'Top Smartphone 2019 from Apple',
      price: 749.99),
  Product(
      imageUrl: 'assets/images/note20ultra.png',
      title: 'Note 20 Ultra',
      brand: 'Samsung',
      producttyp: 'Smartphone',
      description: 'Top Smartphone 2020 from 2020',
      price: 1299.99),
];
