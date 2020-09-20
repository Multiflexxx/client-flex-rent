import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:rent/logic/models/models.dart';
part 'offer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Offer {
  final String offerId;
  final String title;
  final String description;
  final double rating;
  final int numberOfRatings;
  final double price;
  final Category category;
  final List<String> pictureLinks;
  final Lessor lessor;

  Offer(
      {@required this.offerId,
      @required this.title,
      @required this.description,
      @required this.rating,
      @required this.numberOfRatings,
      @required this.price,
      this.category,
      this.pictureLinks,
      this.lessor});
}
