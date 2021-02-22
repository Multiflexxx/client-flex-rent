import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'new_request_numbers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NewRequestNumbers extends Equatable {
  final int lessorsNumberOfNewRequests;
  final int lesseesNumberOfNewAcceptedRequests;
  final int lesseesNumberOfNewRejectedRequests;
  final int lesseesTotalNumberOfUpdates;

  NewRequestNumbers(
      {this.lessorsNumberOfNewRequests,
      this.lesseesNumberOfNewAcceptedRequests,
      this.lesseesNumberOfNewRejectedRequests,
      this.lesseesTotalNumberOfUpdates});

  factory NewRequestNumbers.fromJson(Map<String, dynamic> json) =>
      _$NewRequestNumbersFromJson(json);
  Map<String, dynamic> toJson() => _$NewRequestNumbersToJson(this);

  @override
  List<Object> get props => [
        lessorsNumberOfNewRequests,
        lesseesNumberOfNewAcceptedRequests,
        lesseesNumberOfNewRejectedRequests,
        lesseesTotalNumberOfUpdates,
      ];
}
