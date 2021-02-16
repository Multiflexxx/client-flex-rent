import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'new_request_numbers.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NewRequestNumbers extends Equatable {
  final int numberOfNewRequests;
  final int numberOfNewAcceptedRequests;
  final int numberOfNewRejectedRequests;
  final int totalNumberOfUpdates;

  NewRequestNumbers(
      {this.numberOfNewRequests,
      this.numberOfNewAcceptedRequests,
      this.numberOfNewRejectedRequests,
      this.totalNumberOfUpdates});

  factory NewRequestNumbers.fromJson(Map<String, dynamic> json) =>
      _$NewRequestNumbersFromJson(json);
  Map<String, dynamic> toJson() => _$NewRequestNumbersToJson(this);

  @override
  List<Object> get props => [
        numberOfNewRequests,
        numberOfNewAcceptedRequests,
        numberOfNewRejectedRequests,
        totalNumberOfUpdates
      ];
}
