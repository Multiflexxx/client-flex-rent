import 'package:rent/models/category_model.dart';

class RentProduct {
  String imageUrl;
  String title;
  String brand;
  Category category;
  String description;
  double price;
  int offerId;
  String rating;
  int stars;


  RentProduct(
      {this.imageUrl,
      this.title,
      this.brand,
      this.category,
      this.description,
      this.price,
      this.offerId,
      this.rating,
      this.stars,
      });
}

List<RentProduct> rentProductSuggestionList = [
  RentProduct(
    imageUrl: 'assets/images/teufel.jpg',
    title: 'Teufel BOOMSTER',
    brand: 'Teufel',
    category: categoryList[1],
    description:
        'Bluetooth Teufel Box eigent sich gut für Studentenpartys! Bei mir kommt sie in regelmäßigen Abständen auf Hauspartys zum Einsatz. Der Nachbar hat sich trotz des starken Basses und der lauten Musik noch nie beschwert. Die Box kann aufgeladen werden und überall hin mitgenommen werden.',
    price: 10.00,

  
     rating: 'Lieferung echt super!',
    offerId: 0,
    stars: 3,
  ),
  RentProduct(
    imageUrl: 'assets/images/dyson.jpg',
    title: 'Dyson Turmventialot A07',
    brand: 'Dyson',
    category: categoryList[2],
    description: 'Zu warm? - Dann miete mich!',
    price: 20.00,
 
     rating: 'Das Produkt war schon ok',
    offerId: 1,
    stars: 5,
  ),
  RentProduct(
    imageUrl: 'assets/images/pumpe.jpg',
    title: 'Fahrradpumpe',
    brand: 'none',
    category: categoryList[5],
    description: 'Noch nie benutzte Fahrradpumpe!',
    price: 5.00,
    
    rating: 'Das Produkt ist eigentlich ganz baba',
    offerId: 2,
  ),
  RentProduct(
    imageUrl: 'assets/images/iphone11.png',
    title: 'iPhone 11',
    brand: 'Apple',
    category: categoryList[3],
    description: 'Top Smartphone 2019 from Apple',
    price: 749.99,
   
     rating: '',
    offerId: 3,
  ),

  
];
