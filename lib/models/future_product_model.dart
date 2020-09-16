import 'package:rent/models/category_model.dart';

class FutureProduct {
  String imageUrl;
  String title;
  String brand;
  Category category;
  String description;
  double price;
  int offerId;
  bool rent;

  FutureProduct(
      {this.imageUrl,
      this.title,
      this.brand,
      this.category,
      this.description,
      this.price,
      this.offerId,
      this.rent});
}

List<FutureProduct> futureProductSuggestionList = [
  FutureProduct(
    imageUrl: 'assets/images/teufel.jpg',
    title: 'Teufel BOOMSTER',
    brand: 'Teufel',
    category: categoryList[1],
    description:
        'Bluetooth Teufel Box eigent sich gut für Studentenpartys! Bei mir kommt sie in regelmäßigen Abständen auf Hauspartys zum Einsatz. Der Nachbar hat sich trotz des starken Basses und der lauten Musik noch nie beschwert. Die Box kann aufgeladen werden und überall hin mitgenommen werden.',
    price: 10.00,
    rent: true,
    offerId: 0,
  ),
  FutureProduct(
    imageUrl: 'assets/images/dyson.jpg',
    title: 'Dyson Turmventialot A07',
    brand: 'Dyson',
    category: categoryList[2],
    description: 'Zu warm? - Dann miete mich!',
    price: 20.00,
    rent: true,
    offerId: 1,
  ),
  FutureProduct(
    imageUrl: 'assets/images/pumpe.jpg',
    title: 'Fahrradpumpe',
    brand: 'none',
    category: categoryList[5],
    description: 'Noch nie benutzte Fahrradpumpe!',
    price: 5.00,
    rent: false,
    offerId: 2,
  ),
  FutureProduct(
    imageUrl: 'assets/images/iphone11.png',
    title: 'iPhone 11',
    brand: 'Apple',
    category: categoryList[3],
    description: 'Top Smartphone 2019 from Apple',
    price: 749.99,
    rent: true,
    offerId: 3,
  ),
  FutureProduct(
    imageUrl: 'assets/images/note20ultra.png',
    title: 'Note 20 Ultra',
    brand: 'Samsung',
    category: categoryList[4],
    description: 'Top Smartphone 2020 from 2020',
    price: 1299.99,
    rent: false,
    offerId: 4,
  ),
];
